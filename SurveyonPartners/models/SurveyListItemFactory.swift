//
//  SurveyListItemFactory.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class SurveyListItemFactory {
  
  static var SurveyListArray: [Any] = []
  
  static func create(data: Data) {
    
    SurveyListArray = []
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
      if let dataJson = json!["data"] as? [String: Any] {
        if let profiling = dataJson["profiling"] as? [[String: Any]] {
          for index in 0..<profiling.count {
            let profilingData = Profiling(surveyId: profiling[index]["name"] as? String,
                                          title: profiling[index]["title"] as? String,
                                          url: profiling[index]["url"] as? String)
            SurveyListArray.append(profilingData)
          }
        }
      }
    } catch let error as NSError {
      SOPLog.error(message: error.localizedDescription)
    }
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
      if let dataJson = json!["data"] as? [String: Any] {
        if let research = dataJson["research"] as? [[String: Any]] {
          for index in 0..<research.count {
            let researchData = Research(surveyId: research[index]["survey_id"] as? String,
                                        quotaId: research[index]["quota_id"] as? String,
                                        cpi: research[index]["cpi"] as? String,
                                        ir: research[index]["ir"] as? String,
                                        loi: research[index]["loi"] as? String,
                                        isAnswered: research[index]["is_answered"] as? String,
                                        isClosed: research[index]["is_closed"] as? String,
                                        title: research[index]["title"] as? String,
                                        url: research[index]["url"] as? String,
                                        isFixedLoi: research[index]["is_fixed_loi"] as? String,
                                        isNotifiable: research[index]["is_notifiable"] as? String,
                                        date: research[index]["date"] as? String,
                                        blockedDevices: research[index]["date"] as? String,
                                        extraInfo: research[index]["extra_info"] as? String)
            SurveyListArray.append(researchData)
          }
        }
      }
    } catch let error as NSError {
      SOPLog.error(message: error.localizedDescription)
    }
    
  }
  
}
