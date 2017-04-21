//
//  ImplProfiling.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/04/20.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

struct ImplProfiling: Profiling, SurveyListItem {
  
  var surveyIdLabel: String? { get {return name} }
  
  var name: String?
  
  var title: String?
  
  var url: String?
  
  var surveyId: String? { get {return ""} }
  
  var loi: String? { get {return ""} }
  
  init(name: String?,
       title: String?,
       url: String?) {
    self.name = name
    self.title = title
    self.url = url
  }
  
}
