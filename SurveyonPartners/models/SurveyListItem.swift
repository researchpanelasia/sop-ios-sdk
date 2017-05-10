//
//  SurveyListItem.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

enum SurveyType {
  case Profiling
  case Request
}

protocol SurveyListItem {

  var surveyIdLabel: String { get }

  var title: String { get }

  var url: String{ get }

  var loi: String { get }
}
