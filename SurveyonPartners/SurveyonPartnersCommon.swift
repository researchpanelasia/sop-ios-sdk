//
//  SurveyonPartners+Common.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/10.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class SurveyonPartnersCommom {
    
    static func currentTimeMillis() -> Int64 {
        let sec = Date().timeIntervalSince1970
        return Int64(sec * 1000)
    }
    
    static func getPosixTime() -> String {
        let sec = Date().timeIntervalSince1970
        return String(sec / 1000) + ""
    }
    
    static func adIdUpdatedAt(currentTimeMilles: Int64) {
        PreferencesManager.writePreferences(value: currentTimeMilles, forKey: Constants.SURVEYON_PARTNERS)
    }
    
    static func isNeedAdIdUpdated(currentTimeMilles: Int64) -> Bool {
        let previousTimeMilles: Int64 = PreferencesManager.readIntPreferences(forKey: Constants.SURVEYON_PARTNERS)
        return Constants.DEFAULT_ADID_UPDATE_SPAN <= (currentTimeMilles - previousTimeMilles)
    }
    
}
