//
//  ICTarget.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-11.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation
import ObjectiveC

public class ICTarget: NSObject {
    public static func target (for objectType: ICSerializable.Type) -> String {
        let _class = objectType.classForCoder()
        let target = NSStringFromClass(_class).replacingOccurrences(of: "\(objectType)", with: "")
        return target
    }
}
