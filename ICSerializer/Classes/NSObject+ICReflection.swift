//
//  NSObject+ICReflection.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-09.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation

/// Reflection calls are expensive which is why we store them in a cache
private var reflectionCache = [String: [ICPropertyDescription]]()

extension NSObject {
    
    /// Fetches all property descriptions for the current NSObject
    /// - Note: If we've already fetched the property descriptions for this NSObject before, a cached result will be returned
    /// - Parameter keysToIgnore: If your class has some keys that you don't want to serialize, pass those in here
    /// - Returns: the property descriptions for the current NSObject
    
    public func propertyDescriptions (_ keysToIgnore: [String]? = nil) -> [ICPropertyDescription] {
        let _className = "\(type(of: self))"
        
        if let cachedNames = reflectionCache[_className] {
            return cachedNames
        }
        
        let allProperties = recursivelyFetchPropertyDescriptions()
        var nonSystemProperties = allProperties.filter { (name, type) -> Bool in
            return !ICSystemKeys.isSystemKey(name) && self.responds(to: Selector(name))
        }
        
        if let keysToIgnore = keysToIgnore {
            nonSystemProperties = nonSystemProperties.filter { (name, type) -> Bool in
                return !keysToIgnore.contains(name)
            }
        }
        
        reflectionCache[_className] = nonSystemProperties
        
        return nonSystemProperties
    }
    
    /// Recursively iterates each superclass to the current NSObject to collect all property descriptions
    /// - Parameter currentProperties: The data source being passed on to each recursive call
    /// - Returns: all property descriptions for the calling class + all super classes
    
    private func recursivelyFetchPropertyDescriptions(_ currentProperties: [ICPropertyDescription] = []) -> [ICPropertyDescription] {
        let properties = getPropertyDescriptions()
        var updatedProperties = currentProperties
        updatedProperties.append(contentsOf: properties)
        
        if let superclassObj = value(forKey: "superclass") as? NSObject {
            return superclassObj.recursivelyFetchPropertyDescriptions(updatedProperties)
        } else {
            return updatedProperties
        }
    }
    
    /// Uses the Objc Runtime Reflection feature to get the propertyName + propertyType of all the properties
    /// - Returns: all of the property names and property types in the calling class
    private func getPropertyDescriptions() -> [ICPropertyDescription] {
        
        var descriptions: [ICPropertyDescription] = []
        var count: UInt32 = 0
        // Uses the Objc Runtime to get the property list
        let properties = class_copyPropertyList(classForCoder, &count)
        for i in 0 ..< Int(count) {
            if let property: objc_property_t = properties?[i] {
                let propertyName = property_getName(property)
                let name: String = String(cString: propertyName)
                
                var description: ICPropertyDescription?
                if let propertyType = property_getAttributes(property) {
                    let type: String = String(cString: propertyType)
                    let propType = ICSystemKeys.toPropertyType(type)
                    description = ( name, propType )
                }
                
                if let description = description {
                    descriptions.append(description)
                }
            }
        }
        
        free(properties)
        return descriptions
    }
}
