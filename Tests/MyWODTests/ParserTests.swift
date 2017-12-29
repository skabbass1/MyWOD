
import Foundation
import Quick
import Nimble
import MyWODCore

class ParserSpec: QuickSpec {
    override func spec() {
        it("Extracts WOD details from HTML page correctly") {
            var fileHandle = FileHandle(forReadingAtPath: "Tests/MyWODTests/TestData.html")
            let contents = String(data: fileHandle!.readDataToEndOfFile(), encoding: .utf8)
            fileHandle?.closeFile()
            
            fileHandle = FileHandle(forReadingAtPath: "Tests/MyWODTests/ExpectedParserOutput.txt")
            let expected = String(data: fileHandle!.readDataToEndOfFile(), encoding: .utf8)
            fileHandle?.closeFile()
            
            let got = Parser.extractWOD(rawHtml: contents!)
         
            expect(got).to(equal(expected))
            
        }
    }
}


