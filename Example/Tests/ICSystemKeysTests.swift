//
//  ICSystemKeysTests.swift
//  ICSerializer_Tests
//
//  Created by Ajith R Nayak on 2019-01-09.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ICSerializer

class ICSystemKeysTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func systemKeyExists() {
        let validSystemKey = "px_descriptionForAssertionMessage"
        let exists = ICSystemKeys.isSystemKey(validSystemKey)
        XCTAssertTrue(exists)
    }
    
    func invalidSystemKey() {
        let invalidSystemKey = "notSystemKey"
        let exists = ICSystemKeys.isSystemKey(invalidSystemKey)
        XCTAssertFalse(exists)
    }
    
    func capitalizedSystemKey() {
        let invalidSystemKey = "SystemKey"
        let exists = ICSystemKeys.isSystemKey(invalidSystemKey)
        XCTAssertTrue(exists)
    }
    
    func emptySystemKey() {
        let emptyKey = ""
        let exists = ICSystemKeys.isSystemKey(emptyKey)
        XCTAssertTrue(exists)
    }
}
