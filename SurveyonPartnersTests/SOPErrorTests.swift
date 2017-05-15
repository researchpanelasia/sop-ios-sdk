//
//  SOPErrorTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class SOPErrorTests: XCTestCase {

  func testInit() {
    let error = SOPError(message: "hoge", type: .ConnectionError, response:  Response(statusCode: 999, data: nil), error: nil)
    XCTAssertEqual(error.message, "hoge")
    XCTAssertEqual(error.response?.statusCode, 999)
    XCTAssertEqual(error.type,.ConnectionError)
    XCTAssertNil(error.error)
  }
}
