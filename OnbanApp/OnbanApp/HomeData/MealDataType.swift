import Foundation

enum MealDataType: String, CaseIterable {
    case main = "main"
    case soup = "soup"
    case side = "side"
    
    static func convertToURL(by type: Self) -> URL? {
        let baseUrl = "https://api.codesquad.kr/onban/"
        return URL(string: baseUrl + type.rawValue)
    }
}
