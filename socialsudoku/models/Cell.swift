//
//  Cell.swift
//  socialsudoku
//
//  Created by Thomas Topuz on 14.12.22.
//

import Foundation
struct Cell {
    var value: Int
    var isInput: Bool
    
    init(value:Int, isInput: Bool) {
        self.value = value
        self.isInput = isInput
    }
}
