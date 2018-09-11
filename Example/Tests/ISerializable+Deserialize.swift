//
//  ISerializable+Deserialize.swift
//  ICSerializerTests
//
//  Created by Alexander Selling on 2018-09-09.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import XCTest
@testable import ICSerializerDemo

class ISerializable_Deserialize: XCTestCase {
    
    func test1_should_Serialize_Deserialize() {

        let issue = Issue()
        issue.assignees = [Assignee]()
        
        for i in 0..<10 {
            let assignee = Assignee()
            assignee.name = "name_\(i)"
            issue.assignees?.append(assignee)
        }
        issue.assignee = issue.assignees?.first

        let serializedIssue = issue.serializeToDictionary()
        
        let deserializedIssue = Issue.deserialize(serializedIssue)
        XCTAssertTrue(issue.isEqual(deserializedIssue))
    }
    
}
