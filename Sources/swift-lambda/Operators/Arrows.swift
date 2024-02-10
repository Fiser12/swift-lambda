//
//  Arrows.swift
//
//
//  Created by Rubén García on 10/2/24.
//

import Foundation

precedencegroup ForwardApplication {
  associativity: left
}

precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}

precedencegroup ForwardApplicationPrecedence {
    associativity: right
}

precedencegroup ForwardCompositionPrecedence {
    associativity: right
    higherThan: ForwardApplicationPrecedence
}


infix operator |>: ForwardApplication

public func |> <A, B>(a: A, f: (A) -> B) -> B {
  return f(a)
}

infix operator >>>: ForwardComposition

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
  return { a in
    g(f(a))
  }
}

infix operator <|: ForwardApplicationPrecedence

public func <| <A, B>(f: (A) -> B, a: A) -> B {
  return f(a)
}

infix operator <<<: ForwardCompositionPrecedence

public func <<< <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> ((A) -> C) {
  return { a in 
      f(g(a))
  }
}
