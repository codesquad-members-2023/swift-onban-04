import Foundation

enum ServerURL: String, CaseIterable {
    case main = "main"
    case soup = "soup"
    case side = "side"
    
    static func make(_ url: Self) -> URL? {
        let baseUrl = "https://api.codesquad.kr/onban/"
        return URL(string: baseUrl + url.rawValue)
    }
}
