//
//  File.swift
//  MyWOD
//
//  Created by Syed Abbas on 12/28/17.
//

import Foundation
import Alamofire


public final class ScheduleRequest {
    
    public static func get(forDate: Date) {
        
        Alamofire.request(getResourceURLForDate(forDate: forDate))
            .responseString{ response  in  print(String(data:response.data!, encoding: .utf8))}
    }
    
    public static func getResourceURLForDate(forDate: Date) -> String {
        let formattedDate = formatDate(date: forDate)
        return "http://www.crossfitdefined.com/\(formattedDate)/"
    }
    
    static func formatDate(date: Date) -> String {
        let weekday = Calendar.current.component(.weekday, from: date)
        let day = Calendar.current.component(.day, from: date)
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        
        let weekDaySymbol = DateFormatter().standaloneWeekdaySymbols[weekday - 1].lowercased()
        let monthSymbol = DateFormatter().standaloneMonthSymbols[month - 1].lowercased()
        let dayString = "\(day)\(Utils.getMonthDayOrdinalSufix(forDay: day))"
        
        return "\(weekDaySymbol)-\(monthSymbol)-\(dayString)-\(year)"
    }
}
