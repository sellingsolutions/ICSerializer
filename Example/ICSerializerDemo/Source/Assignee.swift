//
//  Assignee.swift
//  ICSerializerTests
//
//  Created by Alexander Selling on 2018-09-09.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import ICSerializer

class Assignee: ICSerializable {
    override var keysToNotSerialize: [String]? {
        get {
            var keys = ["description"]
            if let superKeys = super.keysToNotSerialize {
                keys.append(contentsOf: superKeys)
            }
            return keys
        }
        set {}
    }
    
    var name: String?

    override func isEqual(_ object: Any?) -> Bool {
        if let assignee = object as? Assignee {
            return name == assignee.name
        }
        return false
    }
}
