//
//  SwiftGenerator.swift
//  CopyEditorExtension
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation

func generateInitializers(forFile content : [String], withSelection selection: [String]) -> [String] {
    let names = artifactName(fromLines: content)
    let fields = extractFields(fromLines: selection).flatMap(toField)
    if names.count > 0 {
        let constructor = constructorFrom(fields: fields)
        let copyMethod = copyMethodFrom(fields: fields, forArtifact: names[0])
        let code = constructor + [""] + copyMethod
        return code
    } else {
        return []
    }
}

func constructorFrom(fields : [Field]) -> [String] {
    let fieldsDeclaration = fields.map{ field in field.declaration() }.joined(separator: ", ")
    let fieldsAssignment = fields.map{ field in "\t\tself.\(field.name) = \(field.name)"}
    return ["\tinit(\(fieldsDeclaration)) {"] + fieldsAssignment + ["\t}"]
}

func copyMethodFrom(fields : [Field], forArtifact name : String) -> [String] {
    let fieldsDeclaration = fields.map{ field in field.optionalDeclaration() }
        .map{ declaration in "\(declaration) = nil" }
        .joined(separator: ", ")
    let fieldsAssignment = fields.map{ field in "\(field.name) : \(field.name) ?? self.\(field.name)" }
        .joined(separator: ", ")
    return ["\tfunc copy(\(fieldsDeclaration)) -> \(name) {", "\t\treturn \(name)(\(fieldsAssignment))", "\t}"]
}
