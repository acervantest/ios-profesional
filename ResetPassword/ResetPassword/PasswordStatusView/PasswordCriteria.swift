//
//  PasswordCriteria.swift
//  ResetPassword
//
//  Created by Alejandro Cervantes on 2024-04-17.
//

import Foundation

struct PasswordCriteria {
    static func lenghtCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }

    static func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    static func lengthAndNoSpaceMet(_ text: String) -> Bool {
        lenghtCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
}
