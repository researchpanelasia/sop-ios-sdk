//
//  SOPLog.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class SOPLog{
  
  class func debug(
    message: String,
    function: String = #function,
    file: String = #function,
    line: Int = #line) { SOPLog.write(loglevel: "[DEBUG]", message: message, function: function, file: file, line: line) };
  class func info(
    message: String,
    function: String = #function,
    file: String = #function,
    line: Int = #line) { SOPLog.write(loglevel: "[INFO]", message: message, function: function, file: file, line: line) };
  class func warning(
    message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line) { SOPLog.write(loglevel: "[WARNING]", message: message, function: function, file: file, line: line) };
  class func error(
    message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line) { SOPLog.write(loglevel: "[ERROR]", message: message, function: function, file: file, line: line) };
  
  class func write(
    loglevel: String,
    message: String,
    function: String,
    file: String,
    line: Int) {
    
    let now = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.timeStyle = .medium
    dateFormatter.dateStyle = .medium
    
    let nowdate = dateFormatter.string(for: now)
    
    var filename = file
    if let match = filename.range(of: "[^/]*$") {
      filename = filename.substring(with: match)
    }
    print("\(loglevel) \"\(message)\" \(nowdate) L\(line) \(function) @\(filename)")
  }
  
}
