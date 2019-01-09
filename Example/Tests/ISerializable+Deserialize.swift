//
//  ISerializable+Deserialize.swift
//  ICSerializerTests
//
//  Created by Alexander Selling on 2018-09-09.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import XCTest
import ICSerializer

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
    
    func test2_shouldExcludeUIKitObjects() {
        //given
        let myProfile = Profile(name: "Ajith R Nayak", profilePhoto: UIImage(), favrtColor: UIColor.red)
        // when
        let serializedIssue = myProfile.serializeToDictionary()
        let name = serializedIssue["name"]
        let profilePhoto = serializedIssue["profilePhoto"]
        let favrtColor = serializedIssue["favrtColor"]
        //then
        XCTAssertEqual(serializedIssue.count, 1)
        XCTAssertNotNil(name)
        XCTAssertNil(profilePhoto)
        XCTAssertNil(favrtColor)
    }
}

extension ISerializable_Deserialize {
    
    class Profile: ICSerializable {
        var name: String?
        var profilePhoto: UIImage?
        var favrtColor: UIColor?
        
        init(name: String, profilePhoto: UIImage,
             favrtColor: UIColor) {
            self.name = name
            self.profilePhoto = profilePhoto
            self.favrtColor = favrtColor
        }
        
        required init() {
            super.init()
            self.name = nil
            self.profilePhoto = nil
            self.favrtColor = nil
        }
    }
}
