//
//  SurveyListItemFactoryTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class SurveyListItemFactoryTests: XCTestCase {

  func testCreate() throws{
    let response = "{" +
      "  \"meta\": {" +
      "    \"code\": 200," +
      "    \"message\": \"\"" +
      "  }," +
      "  \"data\": {" +
      "    \"profiling\": [" +
      "      {" +
      "        \"name\": \"q001\"," +
      "        \"title\": \"请问您的生日是多少?\"," +
      "        \"url\": \"https://partners.surveyon.com/resource/auth/v1_1\"" +
      "      }" +
      "    ]," +
      "    \"research\": [" +
      "      {" +
      "        \"survey_id\": \"10000\"," +
      "        \"quota_id\": \"20000\"," +
      "        \"cpi\": \"1.23\"," +
      "        \"ir\": \"80\"," +
      "        \"loi\": \"10\"," +
      "        \"is_answered\": \"0\"," +
      "        \"is_closed\": \"0\"," +
      "        \"title\": \"Example Research Survey\"," +
      "        \"url\": \"https://partners.surveyon.com/resource/auth/v1_1\"," +
      "        \"is_fixed_loi\": \"1\"," +
      "        \"is_notifiable\": \"1\"," +
      "        \"date\": \"2015-01-01\"," +
      "        \"blocked_devices\": {" +
      "          \"PC\": 1" +
      "        }," +
      "        \"extra_info\": { }" +
      "      }," +
      "      {" +
      "        \"survey_id\": \"10002\"," +
      "        \"quota_id\": \"20002\"," +
      "        \"cpi\": \"2.34\"," +
      "        \"ir\": \"90\"," +
      "        \"loi\": \"10\"," +
      "        \"is_answered\": \"0\"," +
      "        \"is_closed\": \"1\"," +
      "        \"title\": \"hoge\"," +
      "        \"url\": \"\"," +
      "        \"is_fixed_loi\": \"0\"," +
      "        \"is_notifiable\": \"0\"," +
      "        \"date\": \"2015-01-03\"," +
      "        \"blocked_devices\": {" +
      "          \"MOBILE\": 1," +
      "          \"TABLET\": 1" +
      "        }," +
      "        \"extra_info\": { }" +
      "      }" +
      "    ]" +
      "  }" +
    "}"

    let items = try SurveyListItemFactory.create(data: response.data(using: .utf8)!)
    XCTAssertEqual(items[0].title, "请问您的生日是多少?")
    XCTAssertEqual(items[1].title, "Example Research Survey")
    XCTAssertEqual(items[2].title, "hoge")
  }
}
