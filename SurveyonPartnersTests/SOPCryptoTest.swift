//
//  SOPCryptoTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//
import XCTest
import SOPCrypto

class SOPCryptoTests: XCTestCase {

  func testHmacSha256() {
    XCTAssertEqual(SOPCrypto.hmacSha256("string", key: "key"), "97d15beaba060d0738ec759ea31865178ab8bb781b2d2107644ba881f399d8d6")
  }
}
