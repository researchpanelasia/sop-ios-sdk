//
//  ResponseTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class ResponseTests: XCTestCase {

  func testInit() {
    let res = Response(statusCode: 200, data: Data(base64Encoded: "hoge"), error: NSError(domain: "fuga", code: 999, userInfo: nil))
    XCTAssertEqual(res.statusCode, 200)
    XCTAssertEqual(res.data?.base64EncodedString(), "hoge")
    XCTAssertEqual(res.error?.code, 999)
  }
}
