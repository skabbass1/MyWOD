
import Foundation

public final class Parser {
    
    public static func extractWOD(rawHtml: String) -> String {
        
        var post = extractPost(rawHtml: rawHtml)
        post = removeAnnouncements(postLines: post)!
        post = removePhotos(postLines: post)
        return extractWODDetails(postLines: post).joined(separator:"\n\n")
      
    }
    
    static func extractPost(rawHtml: String) -> [String] {
        let lines = rawHtml.split(separator: "\n")
        var postStartIndex = -1
        var postEndIndex =  -1
        
        for (lineno, lineContent) in lines.enumerated() {
            if lineContent.contains("post-info"){
                postStartIndex = lineno
            }
            else if lineContent.contains("post-meta") {
                postEndIndex = lineno
            }
        }
        
        return lines[postStartIndex..<postEndIndex].map{String($0)}
      
        
    }
    
    static func removeAnnouncements(postLines: [String]) -> [String]? {
        if let announcementsEndIndex = postLines.index(of: "<hr />"){
            let distance = postLines.startIndex.distance(to: announcementsEndIndex) + 1
            return postLines[distance...].map{String($0)}
        }
       return nil
    }
    
    static func removePhotos(postLines: [String]) -> [String] {
        var photoStartIndex = -1
      
        for (lineno, lineContent) in postLines.enumerated() {
            if lineContent.contains("/wp-content/uploads/"){
                photoStartIndex = lineno
                 break
            }
        }
        
        return postLines[postLines.startIndex..<photoStartIndex].map{String($0)}
    }
    
    static func extractWODDetails(postLines: [String]) -> [String]{
        let tagStart: Character = "<"
        let tagEnd: Character = ">"
        var wodDetails:[String] = []
        for line in postLines {
            var discardModeOn = false
            var stringBuilder = ""
            for char in line{
                if char == tagStart {
                    discardModeOn = true
                }
                else if char == tagEnd {
                    discardModeOn = false
                }
                if !discardModeOn && char != ">" {
                    stringBuilder.append(char)
                }
            }
            wodDetails.append(stringBuilder)
        }
        return wodDetails
    }
}
