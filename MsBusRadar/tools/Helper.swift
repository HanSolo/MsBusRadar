//
//  Helper.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 28.04.26.
//

import Foundation
import MapKit
import SystemConfiguration


public class Helper {
    public static func isICloudAvailable() -> Bool {
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    public static func toDegrees(_ radians: Double) -> Double {
        return radians * 180 / .pi
    }
    public static func toRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    
    public static func clamp(min: Double, max: Double, value: Double) -> Double {
        if value < min { return min }
        if value > max { return max }
        return value
    }
    
    public static func distance(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        let ac: Double = abs(y2 - y1)
        let cb: Double = abs(x2 - x1)
        return hypot(ac, cb)
    }

    public static func dateToString(fromDate date: Date, formatString: String) -> String {
        return dateToString(fromDate: date, formatString: formatString, timezone: TimeZone.current)
    }
    public static func dateToString(fromDate date: Date, formatString: String, timezoneIdentifier: String) -> String {
        return dateToString(fromDate: date, formatString: formatString, timezone: TimeZone(identifier: timezoneIdentifier) ?? .current)
    }
    public static func dateToString(fromDate date: Date, formatString: String, timezone: TimeZone) -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.timeZone   = timezone
        dateFormatter.dateFormat = formatString.isEmpty ? "dd.MM.yyyy HH:mm:ss" : formatString
        return dateFormatter.string(from: date)
    }
    
    public static func secondsToHHMMString(seconds: Double) -> String {
        if seconds.isInfinite || seconds.isNaN { return "--:--" }
        let hhmmss : (Int, Int) = secondsToHHMM(seconds: seconds)
        return String(format:"%02d:%02d", hhmmss.0, hhmmss.1)
    }
    public static func secondsToHHMM(seconds: Double) -> (Int, Int) {
        if seconds.isInfinite || seconds.isNaN { return (0,0) }
        let minutes : Int = Int((seconds / 60.0).truncatingRemainder(dividingBy: 60.0))
        let hours   : Int = Int((seconds / (3600.0)).truncatingRemainder(dividingBy: 24.0))
        return ( hours, minutes )
    }
    
    public static func secondsToDDHHMMString(seconds: Double) -> String {
        if seconds.isInfinite || seconds.isNaN { return "--:--" }
        let ddhhmm : (Int, Int, Int) = secondsToDDHHMM(seconds: seconds)
        if ddhhmm.0 == 0 {
            return String(format:"%02d:%02d", ddhhmm.1, ddhhmm.2)
        } else {
            return String(format:"%02d:%02d:%02d", ddhhmm.0, ddhhmm.1, ddhhmm.2)
        }
        
    }
    public static func secondsToDDHHMM(seconds: Double) -> (Int, Int, Int) {
        if seconds.isInfinite || seconds.isNaN { return (0, 0, 0) }
        let minutes : Int = Int((seconds / 60.0).truncatingRemainder(dividingBy: 60.0))
        let hours   : Int = Int((seconds / (3_600.0)).truncatingRemainder(dividingBy: 24.0))
        let days    : Int = Int((seconds / (86_400.0)))
        return ( days, hours, minutes )
    }
    
    public static func secondsToHHMMSSString(seconds: Double) -> String {
        if seconds.isInfinite || seconds.isNaN { return "--:--:--"}
        let hhmmss : (Int, Int, Int) = secondsToHHMMSS(seconds: seconds)
        return String(format:"%02d:%02d:%02d", hhmmss.0, hhmmss.1, hhmmss.2)
    }
    public static func secondsToHHMMSS(seconds: Double) -> (Int, Int, Int) {
        if seconds.isInfinite || seconds.isNaN { return (0, 0, 0) }
        let secs    : Int = Int(seconds.truncatingRemainder(dividingBy: 60))
        let minutes : Int = Int((seconds / 60.0).truncatingRemainder(dividingBy: 60.0))
        let hours   : Int = Int((seconds / (3600.0)).truncatingRemainder(dividingBy: 24.0))
        return ( hours, minutes, secs )
    }
}


