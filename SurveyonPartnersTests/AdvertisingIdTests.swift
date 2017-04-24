//
//  AdvertisingIdTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class AdvertisingIdTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdvertisingIdNotNil() {
        let adid = AdvertisingId.getAdvertisingIdentifier()
        XCTAssertNotNil(adid)
    }
    
    func testAdvertisingIdSameLimit() {
        let firstLimit = AdvertisingId.getIsAdvertisingTrackingEnabled()
        let secondLimit = AdvertisingId.getIsAdvertisingTrackingEnabled()
        
        XCTAssert(firstLimit == secondLimit)
    }
    
}
