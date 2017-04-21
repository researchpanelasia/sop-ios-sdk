//
//  Research.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public protocol Research {
  
  var surveyId: String? { get }
  
  var title: String? { get }
  
  var loi: String? { get }
  
  var url: String? { get }
  
  var quotaId: String? { get }
  
  var cpi: String? { get }
  
  var ir: String? { get }
  
  var isAnswered: String? { get }
  
  var isClosed: String? { get }
  
  var isFixedLoi: String? { get }
  
  var isNotifiable: String? { get }
  
  var date: String? { get }
  
  var blockedDevices: String? { get }
  
  var extraInfo: String? { get }
  
}
