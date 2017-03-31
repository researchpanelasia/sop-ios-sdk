//
//  Profiling.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class Profiling: SurveyListItemProtocol {
  
  var jsonObject: Data?
  
  var surveyId: String?
  
  var title: String?
  
  var loi: String?
  
  var url: String?
  
  init(jsonObject: Data?) {
    
    self.jsonObject = jsonObject
    
    if let json = try? JSONSerialization.jsonObject(with: jsonObject!) as? [String:Any],
      let profiling = json?["profiling"] as? [String:Any],
      let name = profiling["name"] as? String,
      let title = profiling["title"] as? String,
      let url = profiling["url"] as? String {
      self.surveyId = name
      self.title = title
      self.url = url
    } else {
      SOPLog.error(message: "bad json")
    }
  }
  
}
