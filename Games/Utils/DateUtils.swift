//
//  DateUtils.swift
//  Games
//
//  Created by Joonik 5 on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation


open class DateUtils {
    
    
    /**
     Parses a string to date if no format is received, function will try with a group of know formats
     */
    class func parseStringToDate(_ dateStr:String, dateFormat: String? = "", timeZone : TimeZone = TimeZone(identifier: "UTC")!) -> Date? {
        var dateStr = dateStr
        let dateFmt = DateFormatter()
        dateFmt.timeZone = timeZone
        if dateFormat!.isEmpty {
            dateStr = dateStr.replacingOccurrences(of: "T", with: " ")
            dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
            if (dateFmt.date(from: dateStr) != nil) {
                return dateFmt.date(from: dateStr)!
            }else{
                dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
                if (dateFmt.date(from: dateStr) != nil) {
                    return dateFmt.date(from: dateStr)!
                } else {
                    if dateStr.count >= 19{
                        dateStr = (dateStr as NSString ).substring(with: NSRange(location: 0, length: 19))
                    }
                    dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if dateFmt.date(from: dateStr) != nil {
                        return dateFmt.date(from: dateStr)!
                    } else {
                        dateFmt.dateFormat = "yyyy:MM:dd HH:mm:ss"
                        if  dateFmt.date(from: dateStr) != nil {
                            return dateFmt.date(from: dateStr)!
                        } else {
                            dateStr = (dateStr as NSString ).substring(with: NSRange(location: 0, length: 10))
                            dateFmt.dateFormat = "dd/MM/yyyy"
                            if dateFmt.date(from: dateStr) != nil {
                                return dateFmt.date(from: dateStr)!
                            } else {
                                dateFmt.dateFormat = "yyyy-MM-dd"
                                if dateFmt.date(from: dateStr) != nil {
                                    return dateFmt.date(from: dateStr)!
                                } else {
                                    dateFmt.dateFormat = "yyyy:MM:dd"
                                    if dateFmt.date(from: dateStr) != nil {
                                        return dateFmt.date(from: dateStr)!
                                    } else {
                                        return nil
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        } else {
            dateFmt.dateFormat = dateFormat!
            return dateFmt.date(from: dateStr)
        }
    }
    
    /**
     Parses a date to string if no format is received, function will try asignt one
     */
    class func parseDateToString(_ date: Date, dateFormat: String? = "") -> String {
        let formatter = DateFormatter()
        if dateFormat!.isEmpty {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = dateFormat!
            return formatter.string(from: date)
        }
        
    }
    
    
    
}
