//
//  Constants.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/09.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

// Preferences
let SURVEYON_PARTNERS: String = "surveyonPartners"

// after 14 days, update idfa
let DEFAULT_ADID_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000

// frifix sop_
let PREFIX_SOP_ = "sop_"

// HTTPCLIENT
let HTTPS = "https://"
let HTTP = "http://"
let DEFAULT_SOP_HOST = "partners.surveyon.com"
let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
let PATH_GET_SURVEY = "/api/v1_1/surveys/json"
let PATH_POST_IDFA = "/api/v1_1/resource/app/member/identifier/apple_idfa"
let POST = "POST"
let GET = "GET"

// IDFA

// Requst
let CONNECT_TIMEOUT = 10000
let READ_TIMEOUT = 10000

// Response Key
let KEY_META = "meta"
let KEY_CODE = "code"
let KEY_MESSAGE = "messase"
let KEY_DATA = "data"
let KEY_PROFILING = "profiling"
let KEY_NAME = "name"
let KEY_SURVEY_ID = "survey_id"
let KEY_QUOTA_ID = "quota_id"
let KEY_CPI = "cpi"
let KEY_IR = "ir"
let KEY_LOI = "loi"
let KEY_IS_ANSWERED = "is_answered"
let KEY_IS_CLOSED = "is_closed"
let KEY_TITLE = "title"
let KEY_URL = "url"
let KEY_IS_FIXED_LOI = "is_fixed_loi"
let KEY_IS_NOTIFIABLE = "is_notifiable"
let KEY_DATE = "date"
let KEY_BLOCKED_DEVICES = "blocked_devices"
let KEY_EXTRA_INFO = "extra_info"
let KEY_POINT = "point"
let KEY_COMPLETE = "complete"
let KEY_SCREENOUT = "screenout"
let KEY_QUOTAFULL = "quotafull"

let KEY_PC = "PC"
let KEY_MOBILE = "MOBILE"
let KEY_TABLET = "TABLET"
