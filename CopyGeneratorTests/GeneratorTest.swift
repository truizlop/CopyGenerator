//
//  GeneratorTest.swift
//  CopyGeneratorTests
//
//  Created by Tomás Ruiz López on 27/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest

class GeneratorTest: XCTestCase {

    func testGeneratesConstructorAndCopyMethod() {
        let actual = generateInitializers(forFile: ["struct Person {",
                                                    "  let name : String",
                                                    "  let age : Int",
                                                    "}"],
                                          withSelection: ["let name : String",
                                                          "let age : Int"])
        let expected = ["\tinit(name : String, age : Int) {",
                        "\t\tself.name = name",
                        "\t\tself.age = age",
                        "\t}",
                        "",
                        "\tfunc copy(name : String? = nil, age : Int? = nil) -> Person {",
                        "\t\treturn Person(name : name ?? self.name, age : age ?? self.age)",
                        "\t}"]
        XCTAssertEqual(expected, actual)
    }

}
