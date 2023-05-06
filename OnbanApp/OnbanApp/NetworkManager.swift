import Foundation

struct NetworkManager {
    static let sharedSession = URLSession.shared

    static func request(data type: MealDataType) async throws -> (String, Data) {
        guard let requestURL = MealDataType.convertToURL(by: type) else {
            logger.log("URL is bad.")
            throw RequestError.badURL
        }

        let (data, response) = try await sharedSession.data(from: requestURL)
        let successRange = 200..<300
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            logger.log("Status Code is not Found.")
            throw RequestError.statusCodeIsNil
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              successRange.contains(statusCode) else {
            logger.log("Status Code is out of range. Status Code: \(statusCode)")
            throw RequestError.statusCodeOutOfRange
        }

        return (type.rawValue, data)
    }

    // NetworkManager 인스턴스 생성 가능성을 차단
    private init() { }
}

enum RequestError: Error {
    case badURL
    case statusCodeIsNil
    case statusCodeOutOfRange
}
