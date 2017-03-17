//
//  Constants.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/09.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class Constants {
    
    // Preferences
    static let SURVEYON_PARTNERS: String = "surveyonPartners"
    
    // after 14 days, update idfa
    static let DEFAULT_ADID_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000
    
    // frefix sop_
    static let PREFIX_SOP_ = "sop_"
    
    // HTTPCLIENT
    static let HTTPS = "https://"
    static let HTTP = "http://"
    static let DEFAULT_SOP_HOST = "partners.surveyon.com"
    static let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
    static let PATH_GET_SURVEY = "/api/v1_1/surveys/json"
    static let PATH_POST_IDFA = "/api/v1_1/resource/app/member/identifier/apple_idfa"
    
    // IDFA
    
    // Request
    static let CONNECT_TIMEOUT = 10000
    static let READ_TIMEOUT = 10000
    
    // Response Key
    static let KEY_META = "meta"
    static let KEY_CODE = "code"
    static let KEY_MESSAGE = "messase"
    static let KEY_DATA = "data"
    static let KEY_PROFILING = "profiling"
    static let KEY_NAME = "name"
    static let KEY_SURVEY_ID = "survey_id"
    static let KEY_QUOTA_ID = "quota_id"
    static let KEY_CPI = "cpi"
    static let KEY_IR = "ir"
    static let KEY_LOI = "loi"
    static let KEY_IS_ANSWERED = "is_answered"
    static let KEY_IS_CLOSED = "is_closed"
    static let KEY_TITLE = "title"
    static let KEY_URL = "url"
    static let KEY_IS_FIXED_LOI = "is_fixed_loi"
    static let KEY_IS_NOTIFIABLE = "is_notifiable"
    static let KEY_DATE = "date"
    static let KEY_BLOCKED_DEVICES = "blocked_devices"
    static let KEY_EXTRA_INFO = "extra_info"
    static let KEY_POINT = "point"
    static let KEY_COMPLETE = "complete"
    static let KEY_SCREENOUT = "screenout"
    static let KEY_QUOTAFULL = "quotafull"
    
    static let KEY_PC = "PC"
    static let KEY_MOBILE = "MOBILE"
    static let KEY_TABLET = "TABLET"
    
}

enum MethodType {
    static let POST = "POST"
    static let GET = "GET"
}
