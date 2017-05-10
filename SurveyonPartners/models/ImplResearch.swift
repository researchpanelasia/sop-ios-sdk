//
//  ImpleResearch.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//


struct ResearchInvalidDataError: Error {
}

struct ImplResearch: Research, SurveyListItem {

  var surveyId: String
  
  var title: String
  
  var loi: String
  
  var url: String
  
  var quotaId: String
  
  var cpi: String
  
  var ir: String

  var isAnswered: Bool
  
  var isClosed: Bool
  
  var isFixedLoi: Bool
  
  var isNotifiable: Bool
  
  var date: String
  
  var blockedDevices: [String: Bool]
  
  var extraInfo: [String: AnyObject]

  var surveyIdLabel: String { get {return "r" + surveyId} }

  var name: String { get {return ""} }

  init(json: [String: AnyObject]) throws {
    let getString = {(_ val: String!) throws -> String in try val ?? {throw ResearchInvalidDataError()}()}
    let getBool = {(_ val: String!) throws -> Bool in try getString(val) == "1"}

    self.surveyId = try getString(json["survey_id"] as? String)
    self.title = try getString(json["title"] as? String)
    self.loi = try getString(json["loi"] as? String)
    self.url = try getString(json["url"] as? String)
    self.quotaId = try getString(json["quota_id"] as? String)
    self.cpi = try getString(json["cpi"] as? String)
    self.ir = try getString(json["ir"] as? String)
    self.isAnswered = try getBool(json["is_answered"] as? String)
    self.isClosed = try getBool(json["is_closed"] as? String)
    self.isFixedLoi = try getBool(json["is_fixed_loi"] as? String)
    self.isNotifiable = try getBool(json["is_notifiable"] as? String)
    self.date = try getString(json["date"] as? String)
    self.blockedDevices = ImplResearch.parseBlockedDevice(json["blocked_devices"] as? [String:Int])
    self.extraInfo = json["extra_info"] as? [String: AnyObject] ?? [:]
  }

  static func parseBlockedDevice(_ dic: [String:Int]?) -> [String: Bool] {
    guard let dic = dic else {
      return [:]
    }

    var parsed = [String: Bool]()
    for (k, v) in dic {
      parsed[k] = (v == 1)
    }
    return parsed
  }

  func isMobileBlocked() -> Bool {
    return blockedDevices["MOBILE"] ?? false
  }
}
