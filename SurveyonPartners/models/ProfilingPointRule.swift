//
//  ProfilingPointRule.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/04/06.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public protocol ProfilingPointRule {
  
  func profilingPoint(profiling: Profiling) -> String
  
  func facebookAuthProfilingPoint(profiling: Profiling) -> String
  
  func googleAuthProfilingPoint(profiling: Profiling) -> String
  
  func cookieProfilingPoint(profiling: Profiling) -> String
  
}
