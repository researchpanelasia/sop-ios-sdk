//
//  ImplProfiling.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

struct ProfilingInvalidDataError: Error {
}

class ImplProfiling: Profiling, SurveyListItem {

  var name: String
  
  var title: String
  
  var url: String
  
  var surveyId: String { get {return ""} }
  
  var loi: String { get {return ""} }
  
  var surveyIdLabel: String { get {return name} }

  init(json: [String: AnyObject]) throws {
    let getString = {(_ val: String!) throws -> String in try val ?? {throw ProfilingInvalidDataError()}()}

    self.name = try getString(json["name"] as? String)
    self.title = try getString(json["title"] as? String)
    self.url = try getString(json["url"] as? String)
  }

  func isMobileBlocked() -> Bool {
    return false
  }
}
