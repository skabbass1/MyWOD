//
//  Utils.swift
//  MyWOD
//
//  Created by Syed Abbas on 12/28/17.
//

import Foundation

public final class Utils {
    public static func getMonthDayOrdinalSufix(forDay:Int) -> String {
        switch (forDay){
            
        case 1, 21, 31:
            return "st"
            
        case 2, 22:
            return "nd"
            
        case 3, 23:
            return "rd"
            
        default:
            return "th"
        }
    }
    
    public static func stringToDate(from dateString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
    public static func plainTextToHtml(from plainText: String) -> String {
        return plainText
            .split(separator: "\n")
            .map{"<p>\($0)</p>"}
            .joined()
        
    }
}
