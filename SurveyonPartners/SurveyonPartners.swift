//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/02/23.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import CommonCrypto

public class SurveyonPartners {
    
    class var sharedInstance: SurveyonPartners {
        struct Static {
            static let instance: SurveyonPartners = SurveyonPartners()
        }
        return Static.instance
    }
    
    public class func setUp() {
        print("Start setUp func.")
    }
  
    public class func showSurveyList() {
        print("Start showSurveyList func.")
    }
    
}
