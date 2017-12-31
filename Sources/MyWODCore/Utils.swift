//
//  Utils.swift
//  MyWOD
//
//  Created by Syed Abbas on 12/28/17.
//

import Foundation
import SwiftSMTP

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
    
    public static func sendText(messageBody: String, subject: String = "WOD") {
        let smtpHost = ProcessInfo.processInfo.environment["MYWOD_SMTP_HOST"]
        let loginEmail = ProcessInfo.processInfo.environment["MYWOD_LOGIN_EMAIL"]
        let loginPassword = ProcessInfo.processInfo.environment["MYWOD_LOGIN_PASSWORD"]
        let recipientEmail = ProcessInfo.processInfo.environment["MYWOD_RECIPIENT_EMAIL"]
        let user = ProcessInfo.processInfo.environment["USER"]
        
        let smtp = SMTP(hostname: smtpHost!, email: loginEmail!,  password: loginPassword!)
        let mail = Mail(
            from: User(name:user!, email: loginEmail!),
            to: [User(name: user!, email: recipientEmail!)],
            subject: subject,
            text: messageBody
        )
        smtp.send(mail)
        
    }
}
