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
    
    func test1_systemKeyExists() {
        let validSystemKey = "px_descriptionForAssertionMessage"
        let exists = ICSystemKeys.isSystemKey(validSystemKey)
        XCTAssertTrue(exists)
    }
    
    func test2_invalidSystemKey() {
        let invalidSystemKey = "NotASystemKey"
        let exists = ICSystemKeys.isSystemKey(invalidSystemKey)
        XCTAssertFalse(exists)
    }
    
    func test3_emptySystemKey() {
        let emptyKey = ""
        let exists = ICSystemKeys.isSystemKey(emptyKey)
        XCTAssertTrue(exists)
    }
}
