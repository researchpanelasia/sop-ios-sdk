//
//  SurveyonPartnersCommonTests.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/10.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class SurveyonPartnersCommonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdidUpdatedAtNoRecord() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: "2017-01-01 12:01:00")
        let sec = date!.timeIntervalSince1970
        
        SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Int64(0))
        XCTAssert(SurveyonPartners.isNeedAdIdUpdated(currentTimeMilles: Int64(sec * 1000)) == true)
    }
    
    func testAdidUpdatedWithinSpan() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.date(from: "2017-01-01 12:00:00")
        let sec1 = date1!.timeIntervalSince1970
        
        let date2 = dateFormatter.date(from: "2017-01-15 11:59:59")
        let sec2 = date2!.timeIntervalSince1970
        
        SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Int64(sec1 * 1000))
        XCTAssert(SurveyonPartners.isNeedAdIdUpdated(currentTimeMilles: Int64(sec2 * 1000)) == false)
    }
    
    func testAdidUpdatedOverSpan() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.date(from: "2017-01-01 12:00:00")
        let sec1 = date1!.timeIntervalSince1970
        
        let date2 = dateFormatter.date(from: "2017-01-15 12:00:00")
        let sec2 = date2!.timeIntervalSince1970
        
        SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Int64(sec1 * 1000))
        XCTAssert(SurveyonPartners.isNeedAdIdUpdated(currentTimeMilles: Int64(sec2 * 1000)) == true)
    }
}
