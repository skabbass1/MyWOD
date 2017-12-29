//
//  UtilsTests.swift
//  MyWOD
//
//  Created by Syed Abbas on 12/28/17.
//

import Foundation
import Quick
import Nimble
import MyWODCore

class UtilsSpec: QuickSpec {
    override func spec() {
        it("Returns correct resource URL for given date") {
            let expected = "http://www.crossfitdefined.com/thursday-december-28th-2017/"
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let date = formatter.date(from: "20171228")
            let got = ScheduleRequest.getResourceURLForDate(forDate: date!)
            expect(got).to(equal(expected))
            
        }
    }
}


