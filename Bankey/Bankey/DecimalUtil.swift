//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Alejandro Cervantes on 2024-03-23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
