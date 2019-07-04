//
//  Nameable.swift
//  Rabit
//
//  Created by Hayoung Park on 04/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation

protocol Nameable {
    static func className() -> String
}

extension Nameable {
    static func className() -> String {
        return String(describing: self)
    }
}

extension NSObject: Nameable {}
