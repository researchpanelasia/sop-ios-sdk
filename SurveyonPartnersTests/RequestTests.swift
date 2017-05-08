//
//  RequestTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class RequestTests: XCTestCase {

  func testAddHeaders() {
    let request = Request(url: URL(string: "http://d8aspting.com")!)
    var req = URLRequest(url: URL(string: "http://d8aspting.com")!)
    request.addHeaders(request: &req, headers: ["hoge": "fuga"])
    XCTAssertEqual(req.value(forHTTPHeaderField: "hoge"), "fuga")
  }
}
