//
//  ICIntrospectable.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-10.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation
protocol ICIntrospectable {
    /// The Objc Runtime reflection is implemented using type erasure, which means that you can't see what type an array has. e.g. you'd get NSArray instead of [Issue]
    /// Which is why we're forced to ask for the array types in each class that inherits from ICSerializable
    /// https://stackoverflow.com/a/31040348/2536815
    var arrayTypes: [String: AnyClass]? { get }
}
