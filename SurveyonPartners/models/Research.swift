//
//  Research.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class Research: SurveyListItemProtocol {
  
  static let MOBILE_BLOCKED = "MOBILE"
  
  public var surveyId: String?
  
  public var title: String?
  
  public var loi: String?
  
  public var url: String?
  
  var quotaId: String?
  
  var cpi: String?
  
  var ir: String?
  
  var isAnswered: String?
  
  var isClosed: String?
  
  var isFixedLoi: String?
  
  var isNotifiable: String?
  
  var date: String?
  
  var blockedDevices: String?
  
  var extraInfo: String?
  
  init(surveyId: String?,
       quotaId: String?,
       cpi: String?,
       ir: String?,
       loi: String?,
       isAnswered: String?,
       isClosed: String?,
       title: String?,
       url: String?,
       isFixedLoi: String?,
       isNotifiable: String?,
       date: String?,
       blockedDevices: String?,
       extraInfo: String?) {
    self.surveyId = surveyId
    self.quotaId = quotaId
    self.cpi = cpi
    self.ir = ir
    self.loi = loi
    self.isAnswered = isAnswered
    self.isClosed = isClosed
    self.title = title
    self.url = url
    self.isFixedLoi = isFixedLoi
    self.isNotifiable = isNotifiable
    self.date = date
    self.blockedDevices = blockedDevices
    self.extraInfo = extraInfo
  }
  
}
