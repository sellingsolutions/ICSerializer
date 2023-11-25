//
//  ICSerializable.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-08.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation
import ObjectiveC

@objcMembers
@objc open class ICSerializable: NSObject, ICIntrospectable, ICUndesiredKeys {
    
    /// The Objc Runtime reflection is implemented using type erasure, which means that you can't see what type an array has. e.g. you'd get NSArray instead of [Issue]
    /// Which is why we're forced to ask for the array types in each class that inherits from ICSerializable
    /// https://stackoverflow.com/a/31040348/2536815
    open var arrayTypes: [String: AnyClass]?
    
    // [ "keyNameToExcludeFromSerialization" ]
    
    /// Properties that won't be serialized
    open var keysToNotSerialize: [String]? = ["description", "arrayTypes", "keysToNotSerialize", "serializationKeyTransforms"]
    
    // Uses the original key name when fetching the value from the NSObject
    // Uses the destination key name when serializing to JSON
    // e.g. [ "originalKeyName" : "destinationKeyName" ]
    
    /// Properties that will have its name transformed to avoid conflicts
    open var serializationKeyTransforms: [String : String]? = ["_description" : "description"]
    
    required public override init() {
        super.init()
    }
    
    /// - Note: Defaults to .deep serialization
    /// - Parameter option: Accepts either .deep or .shallow serialization
    /// - Returns: A Dictionary representing the entire object graph of the serialized object
    
    public func serializeToDictionary(_ option: ICSerializationOption = .deep) -> ICJSONDictionary {
        var dictionary = ICJSONDictionary()
        
        // Used the obj-c runtime reflection to get all the property names
        // the reflection calls are however cached, i.e. reflection only runs once per class
        let properties = self.propertyDescriptions(keysToNotSerialize)
        
        for (propName, _) in properties {
            guard self.responds(to: Selector(propName)) else {
                continue
            }
            let originalKeyName = propName
            let originalValue = value(forKey: originalKeyName)
            
            var jsonKey = originalKeyName
            if let alternateKeyName = serializationKeyTransforms?[originalKeyName] {
                jsonKey = alternateKeyName
            }
            
            // We only serialize properties that have a value, props that are nil will be ignored
            guard let objectValue: AnyObject = originalValue as AnyObject? else {
                continue
            }
            
            //ignore UIKit objects
            if objectValue is UIImage || objectValue is UIColor {
                continue
            }
            
            if let array = objectValue as? [ICSerializable], option == .deep {
                var _array = [AnyObject]()
                for e in array {
                    let dict = e.serializeToDictionary()
                    _array.append(dict as AnyObject)
                }
                dictionary[jsonKey] = _array as AnyObject?
            }
            else if let obj = objectValue as? ICSerializable {
                let dict = obj.serializeToDictionary()
                dictionary[jsonKey] = dict as AnyObject?
            }
            else if let date = objectValue as? Date {
                dictionary[jsonKey] = date.description as AnyObject?
            }
            else {
                dictionary[jsonKey] = objectValue
            }
        }
        return dictionary
    }
    
    /// Deserializes a JSON graph where the root object class name is assumed to be equal to the calling class, e.g. Issue.deserialize(jsonObject)
    /// - Note: EXPERIMENTAL - Do not use this in production
    /// - Parameter dictionary: The JSON graph to deserialize
    /// - Parameter option: defaults to .deep which will deserialize the entire graph
    /// - Returns: The deserialized object which will be the root object in the JSON graph
    
    public static func deserialize(_ dictionary: ICJSONDictionary, using option: ICSerializationOption = .deep) -> Self {
        let _instance = self.init()
        
        let properties = _instance.propertyDescriptions(_instance.keysToNotSerialize)

        for (propName, propType) in properties {
            if let keyValue = dictionary[propName] {
                
                if let arrayOfDictionaries = keyValue as? [ICJSONDictionary] {
                    var arrayOfObjects = [ICSerializable]()
                    
                    for dictionary in arrayOfDictionaries {
                        if let arrayType = _instance.arrayTypes?[propName] {
                            let className = "\(arrayType)"
                            if let deserializedObject = deserialize(dictionary, with: className) {
                                arrayOfObjects.append(deserializedObject)
                            }
                        }
                    }
                    
                    _instance.setValue(arrayOfObjects, forKey: propName)
                }
                else if let objectDict = keyValue as? ICJSONDictionary {
                    let deserializedObject = deserialize(objectDict, with: propType)
                    _instance.setValue(deserializedObject, forKey: propName)
                }
                else {
                    if (_instance as NSObject).responds(to: Selector(propName)) {
                        _instance.setValue(keyValue, forKey: propName)
                    }
                }
            }
        }
        
        return _instance
    }
    
    /// Deserializes a JSON graph with the root object class name specified
    /// - Note: EXPERIMENTAL - Do not use this in production
    /// - Parameter dictionary: The JSON graph to deserialize
    /// - Parameter className: The class name of the root object in the JSON graph
    /// - Returns: The deserialized object which will be an instance of the given className
    
    private static func deserialize(_ dictionary: ICJSONDictionary, with className: String) -> ICSerializable? {
        let target = ICTarget.target(for: self)
        let classPath = "\(target)\(className)"
        
        if let classType = NSClassFromString(classPath) {
            let deserializedObject = (classType as! ICSerializable.Type).deserialize(dictionary)
            return deserializedObject
        }
        return nil
    }
}
