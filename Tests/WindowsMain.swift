//===--- WindowsMain.swift ------------------------------------*- swift -*-===//
//
// This source file is part of the Swift Numerics open source project
//
// Copyright (c) 2019 Apple Inc. and the Swift Numerics project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#if os(Windows)
import XCTest

@testable
import RealTests

@testable
import ComplexTests

@testable
import QuaternionTests

extension ComplexTests.ApproximateEqualityTests {
  static var all = testCase([
    ("testFloat", ComplexTests.ApproximateEqualityTests.testFloat),
    ("testDouble", ComplexTests.ApproximateEqualityTests.testDouble),
  ])
}

extension ComplexTests.ArithmeticTests {
  static var all = testCase([
    ("testPolar", ComplexTests.ArithmeticTests.testPolar),
    ("testBaudinSmith", ComplexTests.ArithmeticTests.testBaudinSmith),
    ("testDivisionByZero", ComplexTests.ArithmeticTests.testDivisionByZero),
  ])
}

extension ComplexTests.PropertyTests {
  static var all = testCase([
    ("testProperties", ComplexTests.PropertyTests.testProperties),
    ("testEquatableHashable", ComplexTests.PropertyTests.testEquatableHashable),
    ("testCodable", ComplexTests.PropertyTests.testCodable),
  ])
}

extension QuaternionTests.ArithmeticTests {
  static var all = testCase([
    ("testMultiplication", QuaternionTests.ArithmeticTests.testMultiplication),
    ("testDivision", QuaternionTests.ArithmeticTests.testDivision),
    ("testDivisionByZero", QuaternionTests.ArithmeticTests.testDivisionByZero),
  ])
}

extension QuaternionTests.PropertyTests {
  static var all = testCase([
    ("testProperties", QuaternionTests.PropertyTests.testProperties),
    ("testEquatableHashable", QuaternionTests.PropertyTests.testEquatableHashable),
    ("testCodable", QuaternionTests.PropertyTests.testCodable),
  ])
}

extension RealTests.ApproximateEqualityTests {
  static var all = testCase([
    ("testFloat", RealTests.ApproximateEqualityTests.testFloat),
    ("testDouble", RealTests.ApproximateEqualityTests.testDouble),
  ])
}

#if swift(>=5.3)
extension ElementaryFunctionChecks {
  static var all = testCase([
    ("testFloat16", ElementaryFunctionChecks.testFloat16),
    ("testFloat", ElementaryFunctionChecks.testFloat),
    ("testDouble", ElementaryFunctionChecks.testDouble),
  ])
}
#else
extension ElementaryFunctionChecks {
  static var all = testCase([
    ("testFloat", ElementaryFunctionChecks.testFloat),
    ("testDouble", ElementaryFunctionChecks.testDouble),
  ])
}
#endif

#if swift(>=5.3)
extension IntegerExponentTests {
  static var all = testCase([
    ("testFloat16", IntegerExponentTests.testFloat16),
    ("testFloat", IntegerExponentTests.testFloat),
    ("testDouble", IntegerExponentTests.testDouble),
  ])
}
#else
extension IntegerExponentTests {
  static var all = testCase([
    ("testFloat", IntegerExponentTests.testFloat),
    ("testDouble", IntegerExponentTests.testDouble),
  ])
}
#endif

var testCases = [
  ComplexTests.ApproximateEqualityTests.all,
  ComplexTests.ArithmeticTests.all,
  ComplexTests.PropertyTests.all,
  QuaternionTests.ArithmeticTests.all,
  QuaternionTests.PropertyTests.all,
  RealTests.ApproximateEqualityTests.all,
  ElementaryFunctionChecks.all,
  IntegerExponentTests.all,
]

#if swift(>=5.3) && canImport(_Differentiation)
extension DifferentiableTests {
  static var all = testCase([
    ("testComponentGetter", DifferentiableTests.testComponentGetter),
    ("testInitializer", DifferentiableTests.testInitializer),
    ("testConjugate",  DifferentiableTests.testConjugate),
    ("testArithmetics", DifferentiableTests.testArithmetics),
  ])
}

testCases += [
  DifferentiableTests.all
]
#endif

XCTMain(testCases)

#endif
