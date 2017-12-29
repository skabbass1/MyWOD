//
//  Utils.swift
//  MyWOD
//
//  Created by Syed Abbas on 12/28/17.
//

import Foundation

public final class Utils {
    static func getMonthDayOrdinalSufix(forDay:Int) -> String {
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
}
