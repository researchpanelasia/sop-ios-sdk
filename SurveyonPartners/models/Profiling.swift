//
//  Profiling.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class Profiling: ProfilingProtocol {
  
  public var name: String?
  
  public var title: String?
  
  public var url: String?
  
  init(name: String?,
       title: String?,
       url: String?) {
    self.name = name
    self.title = title
    self.url = url
  }
  
}
