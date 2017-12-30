//
//  Cli.swift
//  MyWODPackageDescription
//
//  Created by Syed Abbas on 12/29/17.
//

import Foundation
import SwiftSMTP


public final class Cli {
   
    public static func run(arguments: [String] = CommandLine.arguments) throws {
        var forDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        if arguments.count >= 2 {
           
            forDate = Utils.stringToDate(from: arguments[1], format: "yyyyMMdd")
            
            if forDate == nil {
                throw DateParsingError.invalidDateString(
                    "Expected valid date in the format YYYYMMDD. Got '\(arguments[1])' instead"
                )
            }
        }
        ScheduleRequest.get(forDate: forDate!){response in
            if response.response?.statusCode == 200 {
            let wod = Parser.extractWOD(rawHtml: String(data:response.data!, encoding:.utf8)!)
            sendText(messageBody: wod)
            }
            
            else {
                
                let message = "Unable to get WOD for \(String(describing: forDate)). Request returned status code \(String(describing:response.response?.statusCode))"
                sendText(messageBody: message)
            }
        }
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 5))
    }
    
    static func sendText(messageBody: String) {
        let smtpHost = ProcessInfo.processInfo.environment["MYWOD_SMTP_HOST"]
        let loginEmail = ProcessInfo.processInfo.environment["MYWOD_LOGIN_EMAIL"]
        let loginPassword = ProcessInfo.processInfo.environment["MYWOD_LOGIN_PASSWORD"]
        let recipientEmail = ProcessInfo.processInfo.environment["MYWOD_RECIPIENT_EMAIL"]
        let user = ProcessInfo.processInfo.environment["USER"]
        
        let smtp = SMTP(hostname: smtpHost!, email: loginEmail!,  password: loginPassword!)
        let mail = Mail(
            from: User(name:user!, email: loginEmail!),
            to: [User(name: user!, email: recipientEmail!)],
            text: messageBody
        )
         smtp.send(mail)
        
    }
}
