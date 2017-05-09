//
//  ModelHelperTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class ModelHelperTests: XCTestCase {

  func testGetString() {
    XCTAssertEqual(try? ModelHelper.getString(Optional.some("test")), "test")
  }

  func testGetStringNil() {
    do{
      _ = try ModelHelper.getString(Optional.none)
    }catch let error as InvalidResponseError {
      print(error)
    }catch{
      XCTFail()
    }
  }
}
