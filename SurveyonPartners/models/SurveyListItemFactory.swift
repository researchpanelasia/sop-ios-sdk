//
//  SurveyListItemFactory.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class SurveyListItemFactory {
  
  static func create(data: Data) throws -> [SurveyListItem] {
    
    var surveyListItems: [SurveyListItem] = []

    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]

    guard let profilings = (json?["data"]?["profiling"] as? [[String:AnyObject]]) else {
      throw ProfilingInvalidDataError()
    }
    for profile in profilings {
      do {
        try surveyListItems.append(ImplProfiling(json: profile))
      } catch is ProfilingInvalidDataError {
        SOPLog.info(message: "Invalid data in profiling")
      } catch let e {
        throw e
      }
    }

    guard let researchs = (json?["data"]?["research"] as? [[String:AnyObject]]) else {
      throw ResearchInvalidDataError()
    }
    for research in researchs {
      do {
        try surveyListItems.append(ImplResearch(json: research))
      } catch is ResearchInvalidDataError {
        SOPLog.info(message: "Invalid data in research")
      } catch let e {
        throw e
      }
    }

    return surveyListItems
  }
  
}
