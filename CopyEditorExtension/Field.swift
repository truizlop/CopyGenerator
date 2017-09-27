//
//  Field.swift
//  CopyEditorExtension
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation

struct Field {
    let name : String
    let type : String
    
    func declaration() -> String {
        return "\(name) : \(type)"
    }
    
    func optionalDeclaration() -> String {
        if type.hasSuffix("?") {
            return declaration()
        } else if type.hasSuffix("!") {
            return declaration().replacingOccurrences(of: "!", with: "?")
        } else {
            return declaration() + "?"
        }
    }
}

extension Field : Equatable {}

func ==(lhs : Field, rhs : Field) -> Bool {
    return lhs.name == rhs.name &&
            lhs.type == rhs.type
}
