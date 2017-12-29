//
//  Cli.swift
//  MyWODPackageDescription
//
//  Created by Syed Abbas on 12/29/17.
//

import Foundation

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
            print(wod)
            }
            else {
                print(
                "Unable to get WOD for \(String(describing: forDate)). Request returned status code \(String(describing:response.response?.statusCode))"
                )
            }
        }
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 5))
    }
}
