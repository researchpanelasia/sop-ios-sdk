//
//  Utility.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/16.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import SystemConfiguration

final class Utility {
    
    public static func getUserAgent() -> String {
        let appName: String = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return appName + "/" + version + " (" + getDeviceInfo() + ")"
    }
    
    public static func getDeviceInfo() -> String {
        return "iOS:" + getPlatform() + "; Version:" + getDeviceVersion() + ";"
    }
    
    private static func getDeviceVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    private static func getPlatform() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    public static func isOnline() -> Bool {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "google.com")!
        var flags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
