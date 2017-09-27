//
//  ArtifactExtractionTest.swift
//  CopyGeneratorTests
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import XCTest

class ArtifactExtractionTest: XCTestCase {

    func testExtractsClassName() {
        let code = ["// Comment",
                    "public class Person {",
                    "let name : String",
                    "}"]
        let expected = ["Person"]
        let actual = artifactName(fromLines: code)
        XCTAssertEqual(expected, actual)
    }

    func testExtractsStructName() {
        let code = ["// Comment",
                    "internal struct Person {",
                    "let name : String",
                    "}"]
        let expected = ["Person"]
        let actual = artifactName(fromLines: code)
        XCTAssertEqual(expected, actual)
    }
}
