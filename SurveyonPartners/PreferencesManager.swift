//
//  PreferencesManager.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class PreferencesManager {
  
  static func readIntPreferences(forKey: String) -> Int64 {
    let preferences = UserDefaults.standard
    return Int64(preferences.integer(forKey: forKey))
  }
  
  static func writePreferences(value: Int64, forKey: String) {
    let preferences = UserDefaults.standard
    preferences.set(value, forKey: forKey)
    preferences.synchronize()
  }
  
}
