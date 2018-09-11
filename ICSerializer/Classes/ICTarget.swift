//
//  ICTarget.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-11.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation

public class ICTarget: NSObject {
    static private let _class: AnyClass = ICTarget().classForCoder
    public static func currentTarget () -> String {
        let classPath = NSStringFromClass(_class)
        let target = classPath.replacingOccurrences(of: "ICTarget", with: "")
        return target
    }
}
