//
//  ICUndesiredKeys.swift
//  ICSerializer
//
//  Created by Alexander Selling on 2018-09-11.
//  Copyright © 2018 Alexander Selling. All rights reserved.
//

import Foundation

/// `ICUndesiredKeys` is meant to force each class to define which keys it wants to exclude from serialization
protocol ICUndesiredKeys {
    /// Properties that won't be serialized
    var keysToNotSerialize: [String]? { get }
}
