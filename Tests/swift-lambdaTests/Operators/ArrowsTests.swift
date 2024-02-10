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
    // Tests the basic functionality of the pipe forward operator with simple functions
    func testPipeForwardOperatorWithSimpleFunctions() throws {
        let result = 2 |> incr |> square
        XCTAssertEqual(result, 9, "The result of incrementing 2 and then squaring should be 9.")
    }
    
    // Tests the forward composition operator combining two functions into one
    func testForwardCompositionOperator() throws {
        let composedFunction = incr >>> square
        let result = composedFunction(2)
        XCTAssertEqual(result, 9, "The result of composing incr and square functions and applying to 2 should be 9.")
    }
    
    // Tests the application of functions in reverse order to verify the precedence of pipe backward operator
    func testPipeBackwardOperatorWithSimpleFunctions() throws {
        let result = square <| incr <| 2
        XCTAssertEqual(result, 9, "The result of incrementing 2 and then squaring, using the backward pipe, should be 9.")
    }
    
    // Tests the backward composition of functions to ensure correct function composition and application
    func testBackwardCompositionOperator() throws {
        let composedFunction = square <<< incr
        let result = composedFunction <| 2
        XCTAssertEqual(result, 9, "The result of composing incr and square functions in reverse and applying to 2 should be 9.")
    }
    
    func testReversibilityOfComposition() throws {
        let forwardComposition = incr >>> square
        let backwardComposition = square <<< incr
        let forwardResult = forwardComposition(2)
        let backwardResult = backwardComposition(2)
        XCTAssertEqual(forwardResult, backwardResult, "Forward and backward compositions of non-commutative functions should not produce the same result.")
        XCTAssertEqual(forwardResult, 9, "Both should result in 9.")
    }

}

func incr(_ x: Int) -> Int {
    return x + 1
}

func square(_ x: Int) -> Int {
    return x * x
}
