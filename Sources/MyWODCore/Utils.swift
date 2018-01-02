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
    
    public static func sendText(messageBody: String, subject: String = "WOD") {
       
        var request = URLRequest(url: URL(string:ProcessInfo.processInfo.environment["MAILGUN_URL"]!)!)

        let loginData = "api:\(ProcessInfo.processInfo.environment["MAILGUN_API_KEY"]!)".data(using: .utf8)!
        
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let body = constructUrlEncodedFormBody(
            from: [
                "from" : ProcessInfo.processInfo.environment["MAILGUN_FROM"]!,
                "to": ProcessInfo.processInfo.environment["MAILGUN_RECIPIENT_EMAIL"]!,
                "subject": "WOD",
                "text": messageBody
            ]
        )
        
        request.httpBody = body.data(using: .utf8)


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    public static func constructUrlEncodedFormBody(from keyValue: [String:String]) -> String {
    
        let escapeTheseCharacters = "$&+,/:;=?@ "
        var encodedKeyValues = [String: String]()
        for (key, value) in keyValue {
            var dontEscapeTheseCharacters = ""
            for scalar in value.unicodeScalars {
                if scalar.isASCII {
                    let stringValue = String(scalar)
                    if !escapeTheseCharacters.contains(stringValue){
                        dontEscapeTheseCharacters.append(stringValue)
                    }
                }
            }
            encodedKeyValues[key] = value.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: dontEscapeTheseCharacters))!
        }
       
        
        return encodedKeyValues.map{"\($0)=\($1)"}.joined(separator: "&").replacingOccurrences(of: "%20", with: "+")
    }
}
