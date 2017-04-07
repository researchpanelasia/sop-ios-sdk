//
//  Profiling.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class Profiling: SurveyListItemProtocol {
  
  public var surveyId: String?
  
  public var title: String?
  
  public var loi: String?
  
  public var url: String?
  
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
