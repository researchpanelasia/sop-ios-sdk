//
//  Research.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public protocol Research {
  
  var surveyId: String { get }
  
  var title: String { get }
  
  var loi: String { get }
  
  var url: String { get }
  
  var quotaId: String { get }
  
  var cpi: String { get }
  
  var ir: String { get }
  
  var isAnswered: Bool { get }
  
  var isClosed: Bool { get }
  
  var isFixedLoi: Bool { get }
  
  var isNotifiable: Bool { get }
  
  var date: String { get }
  
  var blockedDevices: [String: Bool] { get }
  
  var extraInfo: [String: AnyObject] { get }
}
