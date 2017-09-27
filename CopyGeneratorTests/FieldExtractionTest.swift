//
//  FieldExtractionTest.swift
//  CopyGeneratorTests
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest

class FieldExtractionTest: XCTestCase {

    func testFieldsAreExtracted() {
        let selection = ["private var name : String; let bbb : B // Comment",
                         "internal(set) let age:Int?/**/",
                         "let view : UIView!//",
                         "// No declaration in this line",
                         "let a,b, c : Double?",
                         "let x : (Int, Int)?",
                         "let array : [A]"]
        let expected = ["var name : String",
                        "let bbb : B",
                        "let age:Int?",
                        "let view : UIView!",
                        "let a,b, c : Double?",
                        "let x : (Int, Int)?",
                        "let array : [A]"]
        let actual = extractFields(fromLines: selection)
        XCTAssertEqual(expected, actual)
    }

    func testCreatesFieldObjectsFromDeclaration() {
        let declarations = ["var name : String",
                            "let bbb : B",
                            "let age:Int?",
                            "let view : UIView!",
                            "let a,b, c : Double?",
                            "let x : (Int, Int)?",
                            "let array : [A]"]
        let expected = [Field(name: "name", type: "String"),
                        Field(name: "bbb", type: "B"),
                        Field(name: "age", type: "Int?"),
                        Field(name: "view", type: "UIView!"),
                        Field(name: "a", type: "Double?"),
                        Field(name: "b", type: "Double?"),
                        Field(name: "c", type: "Double?"),
                        Field(name: "x", type: "(Int, Int)?"),
                        Field(name: "array", type: "[A]")]
        let actual = declarations.flatMap(toField)
        XCTAssertEqual(actual, expected)
    }
}
