//
//  File.swift
//  MyWOD
//
//  Created by Syed Abbas on 12/28/17.
//

import Foundation


public final class ScheduleRequest {
    
    public static func get(forDate: Date, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = URL(string: getResourceURLForDate(forDate: forDate))
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url, completionHandler: responseHandler)
            task.resume()
            
        }
        
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
