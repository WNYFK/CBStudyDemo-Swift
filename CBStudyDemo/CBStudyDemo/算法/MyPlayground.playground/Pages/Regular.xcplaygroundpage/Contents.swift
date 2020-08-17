//: [Previous](@previous)

import Foundation

struct MYPTagInfo {
    let tag: String
    let content: String
}
extension String {
    func parase(spTags: [String]) -> [MYPTagInfo] {
        let tags = spTags.joined(separator: "|")
        let reg = "(.*?)<\(tags)>(.*?)</\(tags)>(.*?)$"
        
        let regex = try? NSRegularExpression(pattern: reg, options: .caseInsensitive)
        guard let matches = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)) else { return [] }
        for result in matches {
            print(result.numberOfRanges)
            print(result.range(at: 1))
            print(result.range(at: 2))
            print(result.range(at: 3))
        }
        
        return []
    }
}
"<icon>([^<]*)</icon>"
let string = "数据由微博提供，每日上午9点更新昨日榜单"
string.parase(spTags: ["icon"])





//: [Next](@next)
