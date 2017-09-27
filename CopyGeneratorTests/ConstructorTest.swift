//
//  ConstructorTest.swift
//  CopyGeneratorTests
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest

class ConstructorTest: XCTestCase {

    func testCreatesConstructor() {
        let fields = [Field(name: "name", type: "String"),
                      Field(name: "age", type: "Int")]
        let expected = ["\tinit(name : String, age : Int) {",
                           "\t\tself.name = name",
                           "\t\tself.age = age",
                           "\t}"]
        let actual = constructorFrom(fields: fields)
        XCTAssertEqual(expected, actual)
    }

}
