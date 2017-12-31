//
//  Controller.swift
//  MyWODPackageDescription
//
//  Created by Syed Abbas on 12/30/17.
//

import Foundation
import Kitura
import LoggerAPI
import CloudEnvironment
import Health

public final class Controller {
    public let router: Router
    let cloudEnv: CloudEnv
    let health: Health
    
    public init() {
        self.cloudEnv = CloudEnv()
        self.router = Router()
        self.health = Health()
        
        router.post("/wod/:forDate", handler: sendWOD)
        router.post("/wod", handler: sendWOD)
        router.get("/health", handler: getHealthCheck)
    }
    
    public var port: Int {
        get { return cloudEnv.port }
    }
    
    public var url: String {
        get { return cloudEnv.url }
    }
    
    public func sendWOD(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        Log.debug("POST - /wod route handler...")
        response.headers["Content-Type"] = "text/plain; charset=utf-8"
        let forDate = request.parameters["forDate"] ?? nil
        WOD(forDate: forDate != nil ? Utils.stringToDate(from: forDate!, format: "yyyyMMdd") : nil )
        try response.status(.OK).send("Request for WOD received. You will receive status via text message!").end()
    }
    
    public func getHealthCheck(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        Log.debug("GET - /health route handler...")
        let status = health.status
        if health.status.state == .UP {
            try response.status(.OK).send(status).end()
        } else {
            try response.status(.serviceUnavailable).send(status).end()
        }
    }
    
    func WOD(forDate: Date?) {
        let queryDate = forDate == nil ? Calendar.current.date(byAdding: .day, value: 1, to: Date()): forDate
        ScheduleRequest.get(forDate: queryDate!){ (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                let wod = Parser.extractWOD(rawHtml: String(data:data!, encoding:.utf8)!)
                Log.debug("WOD - \(wod)")
                //Utils.sendText(messageBody: Utils.plainTextToHtml(from:wod))
            }
                
            else {
                
                let message = "Unable to get WOD for \(String(describing: forDate)). Request returned status code \(String(describing:httpResponse?.statusCode))"
                Log.error("WOD - \(message)")
                //Utils.sendText(messageBody: message, subject: "ERROR")
            }
        }
    }
    
}
