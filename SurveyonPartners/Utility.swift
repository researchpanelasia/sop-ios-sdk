//
//  Utility.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import SystemConfiguration

final class Utility {
  
  static func getUserAgent() -> String {
    
    var version: String = ""
    
    if let bundle = SurveyonPartners.getResourceBundle(),
       let obj = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString"),
       let tmpVersion = obj as? String {
      version = tmpVersion
    }
    
    return "sop-ios-sdk" + " " + version + " (" + getDeviceInfo() + ")"
  }
  
  static func getDeviceInfo() -> String {
    return "iOS:" + getPlatform() + "; Version:" + getDeviceVersion() + ";"
  }
  
  static func getDeviceVersion() -> String {
    return UIDevice.current.systemVersion
  }
  
  static func getPlatform() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
  }
  
  static func isOnline() -> Bool {
    let reachability = SCNetworkReachabilityCreateWithName(nil, "google.com")!
    var flags = SCNetworkReachabilityFlags.connectionAutomatic
    if !SCNetworkReachabilityGetFlags(reachability, &flags) {
      return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
  }
  
  static func currentTimeMillis() -> Int64 {
    let sec = Date().timeIntervalSince1970
    return Int64(sec * 1000)
  }
  
  static func getPosixTime() -> String {
    let sec = UInt64(Date().timeIntervalSince1970)
    return String(sec)
  }
  
  static func getPlist() -> [String : AnyObject]? {
    guard let path = Bundle.main.path(forResource: Constants.plistFileName, ofType: "plist"),
      let dic = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
        return nil
    }
    return dic
  }
}
