import Foundation

struct DecodeManager {

    private static let decoder = JSONDecoder()

    static func decode(data: Data) -> MealData? {
        do {
            let decodedData = try decoder.decode(MealData.self, from: data)
            
            return decodedData
        } catch let error {
            // 에러 발생시 에러 원인을 명확하게 로그로 띄우고자 switch문으로 error 타입을 세분화시켰습니다.
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .dataCorrupted(let context):
                    logger.error("데이터 형식을 확인하세요.\n\(context.underlyingError)")
                case .keyNotFound(let codingKey, _):
                    logger.error("key값인 \(codingKey.stringValue)를 찾을 수 없습니다.")
                case .typeMismatch(_, let context):
                    logger.error("\(context.debugDescription)")
                case .valueNotFound(_, let context):
                    logger.error("\(context.debugDescription)")
                }
            }
            return nil
        }
    }
}
