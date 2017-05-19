//
//  ProfilingPointRule.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

@objc public protocol ProfilingPointRule {
  
  func profilingPoint(profiling: Profiling) -> String
  
  func facebookAuthProfilingPoint(profiling: Profiling) -> String
  
  func googleAuthProfilingPoint(profiling: Profiling) -> String
  
  func cookieProfilingPoint(profiling: Profiling) -> String
  
}
