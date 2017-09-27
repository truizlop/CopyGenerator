//
//  SwiftParser.swift
//  CopyEditorExtension
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation

func extract(regExpr : String, fromLine line : String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regExpr, options: .caseInsensitive)
        let range = NSRange(0 ..< line.characters.count)
        let results = regex.matches(in: line as String, options: .reportProgress, range: range)
        return results.map { result in
            String(line[Range(result.range, in: line)!])
        }
    } catch {
        return []
    }
}

func artifactName(fromLines lines : [String]) -> [String] {
    return lines.flatMap(artifactName)
}

func artifactName(fromLine line : String) -> [String] {
    return extract(regExpr: "(class|struct)\\s+\\w+(<\\s*\\w+\\s*>)?", fromLine: line)
            .map{ name in name.replacingOccurrences(of: "struct", with: "")
                              .replacingOccurrences(of: "class", with: "")
                              .trimmingCharacters(in: .whitespacesAndNewlines)
                }
}

func extractFields(fromLines lines : [String]) -> [String] {
    return lines.flatMap(extractField)
                .filter{ line in !line.isEmpty }
}

func extractField(fromLine line : String) -> [String] {
    return extract(regExpr: "(let|var)\\s*\\w+(,\\s*\\w+)*\\s*:\\s*(\\(|\\[)?\\w+(\\s*,\\s*\\w+\\s*)?(\\)|\\])?(\\?|\\!)?", fromLine: line)
}

func toField(_ declaration : String) -> [Field] {
    let noPrefix = declaration.replacingOccurrences(of: "let", with: "")
                              .replacingOccurrences(of: "var", with: "")
    let type = extractType(noPrefix)
    let names = extractNames(noPrefix)
    return names.map{ name in Field(name: name, type: type) }
}

func extractType(_ declaration : String) -> String {
    return declaration.components(separatedBy: ":")[1]
                      .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}

func extractNames(_ declaration : String) -> [String] {
    return declaration.components(separatedBy: ":")[0]
                      .components(separatedBy: ",")
                      .map{ name in name.trimmingCharacters(in: .whitespacesAndNewlines) }
}
