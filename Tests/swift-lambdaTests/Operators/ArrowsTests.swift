//
//  ArrowsTest.swift
//
//
//  Created by Rubén García on 10/2/24.
//

import Foundation
import XCTest
import SwiftLambda

final class ArrowsTests: XCTestCase {
    func testSimpleArrow() throws {
        let operate = 2 |> incr |> square
        XCTAssertTrue(operate == 9)
    }
    
    func testComplexArrow() throws {
        let operate = 2 |> incr >>> square
        XCTAssertTrue(operate == 9)
    }

    func testSimpleArrowPrecedence() throws {
        let operate = square <| incr <| 2
        XCTAssertTrue(operate == 9)
    }
    
    func testComplexArrowPrecedence() throws {
        let operate = square <<< incr <| 2
        XCTAssertTrue(operate == 9)
    }
}

func incr(_ x: Int) -> Int {
  return x + 1
}

func square(_ x: Int) -> Int {
  return x * x
}
