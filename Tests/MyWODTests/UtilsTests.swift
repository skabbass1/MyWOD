//
//  UtilsTests.swift
//  MyWOD
//
//  Created by Syed Abbas on 1/1/18.
//

import Foundation
import Quick
import Nimble
import MyWODCore

class MyWODUtilsSpec: QuickSpec {
    override func spec() {
        it("percent encodes non ascii characters") {
            let expected = "from=Syed+Abbas+<helloworld%40som.domain.com>&to=sabbas123%40hello.com&text=Reverse+Step+Lunges+(L+%2B+R+%3D1)"
            let got = Utils.constructUrlEncodedFormBody(
                from: [
                    "from": "Syed Abbas <helloworld@som.domain.com>",
                    "to": "sabbas123@hello.com",
                    "text": "Reverse Step Lunges (L + R =1)"
                ]
            )
            expect(got).to(equal(expected))
            
        }
    }
}
