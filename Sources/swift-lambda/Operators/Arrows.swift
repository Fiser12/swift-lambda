//
//  Arrows.swift
//
//
//  Created by Rubén García on 10/2/24.
//  Idea got from pointfree episode 1: https://www.pointfree.co/episodes/ep1-functions

/** Define the precedence for forward application of functions.
 This group allows for left-to-left chaining of the pipe forward operator, ensuring that operations are applied from left to right as they appear in the code.
 */
precedencegroup ForwardApplication {
  associativity: left
}

/** Define the precedence for forward composition of functions.
 This group ensures that function compositions are evaluated with a higher precedence than forward application, allowing for seamless chaining of composed functions.
 */
precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}

/**
 Defines a precedence group for applying a function to a value with right associativity. This group allows for a right-to-left evaluation order, which can be useful in certain contexts to reverse the natural flow of function application, making the code more flexible and expressive.
 */
precedencegroup ForwardApplicationPrecedence {
    associativity: right
}

/**
 Defines a precedence group for composing functions with right associativity. Ensuring that compositions are evaluated in a right-to-left order when multiple composition operators are used together. This precedence is essential for constructing intuitive and readable chains of function compositions that behave as expected without explicit parentheses.
 */
precedencegroup ForwardCompositionPrecedence {
    associativity: right
    higherThan: ForwardApplicationPrecedence
}


/** Apply a function to a value.
 This "pipe-forward" operator allows for a more readable, left-to-right syntax when applying functions to values, mirroring the flow of data.
 Inspired by similar operators in languages like F#, Elixir, and Elm, it aims to enhance readability and expressiveness in Swift.
 
 - Parameters:
   - a: The value to apply the function to.
   - f: The function to apply to the value.
 - Returns: The result of applying the function to the given value.
 */
infix operator |>: ForwardApplication

public func |> <A, B>(a: A, f: (A) -> B) -> B {
  return f(a)
}

/** Composes two functions from left to right.
 This "forward compose" or "right arrow" operator enables the chaining of two functions where the output of the first is the input of the second.
 It represents a fundamental concept in functional programming, allowing for the creation of more complex functions from simpler ones without the need for nesting.
 
 - Parameters:
   - f: The first function to apply.
   - g: The second function to apply, which takes the output of the first function as its input.
 - Returns: A new function that represents the composition of `f` and `g`.
 */
infix operator >>>: ForwardComposition

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
  return { a in
    g(f(a))
  }
}

/** Apply a function to a value, with right associativity.
 This operator is similar to `|>`, but with right associativity, allowing for a different grouping of operations without altering the fundamental behavior.
 
 - Parameters:
   - f: The function to apply to the value.
   - a: The value to apply the function to.
 - Returns: The result of applying the function to the given value.
 */
infix operator <|: ForwardApplicationPrecedence

public func <| <A, B>(f: (A) -> B, a: A) -> B {
  return f(a)
}

/** Composes two functions from right to left.
 Opposite to the `>>>` operator, this "backward compose" allows for composing functions in reverse order, which can be useful in certain contexts to improve readability or align with specific logic.
 
 - Parameters:
   - f: The second function to apply.
   - g: The first function to apply, which takes the input and whose output is passed to `f`.
 - Returns: A new function that represents the composition of `g` followed by `f`.
 */
infix operator <<<: ForwardCompositionPrecedence

public func <<< <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> ((A) -> C) {
  return { a in
      f(g(a))
  }
}
