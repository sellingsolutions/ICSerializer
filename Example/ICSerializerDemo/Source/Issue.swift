//
//  Issue.swift
//  ICSerializerTests
//
//  Created by Alexander Selling on 2018-09-09.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//
import ICSerializer

class Issue: ICSerializable {
    
    override var arrayTypes: [String : AnyClass]? {
        get { return ["assignees" : Assignee.self] }
        set {}
    }
    
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
    
    var issueDescription: String?
    var assignees: [Assignee]?
    var assignee: Assignee?
    
    func sortedAssignees () -> [Assignee]? {
        let sorted = assignees?.sorted(by: { (a1, a2) -> Bool in
            if let n1 = a1.name, let n2 = a2.name {
                return n1.compare(n2) == .orderedAscending
            }
            return false
        })
        return sorted
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let issue = object as? Issue {
            
            if issueDescription == issue.issueDescription {
                if let lhs_assignees = sortedAssignees(),
                    let rhs_assignees = issue.sortedAssignees(),
                    lhs_assignees.count == rhs_assignees.count {
                    
                    for i in 0..<lhs_assignees.count {
                        let lhs_assignee = lhs_assignees[i]
                        let rhs_assignee = rhs_assignees[i]
                        if !lhs_assignee.isEqual(rhs_assignee) {
                            return false
                        }
                    }
                    return true
                }
            }
        }
        return false
    }
}
