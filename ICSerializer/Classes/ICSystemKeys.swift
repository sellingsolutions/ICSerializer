//
//  ICSystemKeys.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-09.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation

public class ICSystemKeys: NSObject {
        
    public static func toPropertyType(_ propTypeSignature: String) -> String {
        
        // The Objc Runtime reflection is implemented using type erasure for array types, which means we can't see what type an array has, e.g. issue.assignees
        // but that's only true for array types, property_getAttributes will return the type of object types, e.g. issue.assignee
        // So that is what we're looking for in the propTypeSignature, we're looking for the property type, e.g. `Assignee`
        if propTypeSignature.range(of: "8") != nil {
            let scanner = Scanner(string: propTypeSignature)
            var type: NSString?
            // The property type is always prefixed by the char '8'
            scanner.scanUpTo("8", into: nil)
            scanner.scanString("8", into: nil)
            // The propTypeSignature always delimits the property type with a "
            scanner.scanUpTo("\"", into: &type)
            
            if let type = type {
                return String(type)
            }
        }
        
        return ""
    }
    
    public static func isSystemKey(_ key: String) -> Bool {
        if key.isEmpty {
            return true
        }
        if let first = key.first, first.isUppercase {
            return true
        }
        return systemKeys.contains(key) || !systemKeys.filter({key.contains($0)}).isEmpty
    }
    
    private static let systemKeys: [String] = [
        "accessibility",
        "_accessibility",
        "automation",
        
        "pspdf_",
        "musicKit_",
        "safari_",
        "avkit_",
        "fm_",
        "ax_",
        "_ax",
        "px_",
        "_px",
        "_ui",
        "_at",
        "browser",
        "ic_",
        
        // ICSerializable internal properties
        "keysToNotSerialize",
        "serializationKeyTransforms",
        
        // iOS 13
        "_accessibilityAutomationType",
        "ax_buddyObservedTableViews",
        "ax_buddyDynamicHeightConstraints",
        "_axIsWrappedPointer",
        
        // iOS 12
        "px_descriptionForAssertionMessage",
        
        // iOS 11
        "_ui_descriptionBuilder",
        "_atvaccessibilityITMLAccessibilityContent",
        
        // iOS 10
        "hash",
        "hashValue",
        "superclass",
        "debugDescription",
        
        "px_descriptionForAssertionMessage",
        "_px_reuseIdentifier",
        "accessibilityCustomRotors",
        "akToolbarButtonItemType",
        
       
        "isAccessibilityElement",
        "shouldGroupAccessibilityChildren",
        "traitStorageList",
        "autoContentAccessingProxy",
        "classForKeyedArchiver",
        "observationInfo",
        "knownRepresentedElement",
        "rotorOwnerElement"
    ]
}
