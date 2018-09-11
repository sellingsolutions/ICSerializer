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
    
    static func isSystemKey(_ key: String) -> Bool {
        if key.isEmpty {
            return true
        }
        return systemKeys.contains(key)
    }
    
    private static let systemKeys: [String] = [
        // ICSerializable internal properties
        "keysToNotSerialize",
        "serializationKeyTransforms",
        
        // iOS 12
        "px_descriptionForAssertionMessage",
        
        // iOS 11
        "_ui_descriptionBuilder",
        "_atvaccessibilityITMLAccessibilityContent",
        "accessibilityContainerType",
        "accessibilityLocalizedStringKey",
        "accessibilityAttributedLabel",
        "accessibilityAttributedHint",
        "accessibilityAttributedValue",
        
        // iOS 10
        "hash",
        "hashValue",
        "superclass",
        "debugDescription",
        
        "px_descriptionForAssertionMessage",
        "_px_reuseIdentifier",
        "accessibilityCustomRotors",
        "akToolbarButtonItemType",
        "classForKeyedArchiver",
        
        "accessibilityIdentifier",
        "accessibilityElements",
        "accessibilityCustomActions",
        "isAccessibilityElement",
        "accessibilityLabel",
        "accessibilityHint",
        "accessibilityValue",
        "accessibilityTraits",
        "accessibilityFrame",
        "accessibilityPath",
        "accessibilityActivationPoint",
        "accessibilityLanguage",
        "accessibilityElementsHidden",
        "accessibilityViewIsModal",
        "shouldGroupAccessibilityChildren",
        "accessibilityNavigationStyle",
        "accessibilityHeaderElements",
        "traitStorageList",
        "autoContentAccessingProxy",
        "classForKeyedArchiver",
        "observationInfo",
        
        // PSPDFKit
        "pspdf_KVOController",
        "pspdf_KVOControllerUnretainedObserving",
        "pspdf_accessibility",
    ]
}
