//
//  Profiling.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class Profiling: SurveyListItemProtocol {
  
  var surveyId: String?
  
  var title: String?
  
  var loi: String?
  
  var url: String?
  
  init(surveyId: String?,
       title: String?,
       url: String?,
       loi: String? = "") {
    self.surveyId = surveyId
    self.title = title
    self.url = url
    self.loi = loi
  }
  
}
