//
//  ArrayExtensions.swift
//  Rabit
//
//  Created by Hayoung Park on 04/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
