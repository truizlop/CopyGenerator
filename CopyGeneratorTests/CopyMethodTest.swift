//
//  CopyMethodTest.swift
//  CopyGeneratorTests
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest

class CopyMethodTest: XCTestCase {

    func testCreatesConstructor() {
        let fields = [Field(name: "name", type: "String"),
                      Field(name: "age", type: "Int")]
        let expected = ["\tfunc copy(name : String? = nil, age : Int? = nil) -> Person {",
                        "\t\treturn Person(name : name ?? self.name, age : age ?? self.age)",
                        "\t}"]
        let actual = copyMethodFrom(fields: fields, forArtifact: "Person")
        
        XCTAssertEqual(expected, actual)
    }

}
