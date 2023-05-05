import Foundation

class HomeRepository: Repository {
    // TODO: - 스케줄링 알고리즘 적용 예정. mealDatas 적정 데이터 수를 유지하기 위함
    
    func request(data type: MealDataType) async -> MealData? {
        let task = Task {
            var responseData: MealData?
            do {
                var (_, data) = try await NetworkManager.request(mealData: type)

                guard let decodedData = DecodeManager.decode(data: data) else {
                    throw FetchError.decodingError
                }
                
                responseData = decodedData

            } catch RequestError.badURL {
                logger.error("URL 형식이 잘 못 됬습니다.")
            } catch RequestError.statusCodeIsNil {
                logger.error("HTTP 요청 상태 코드가 존재하질 않습니다.")
            } catch FetchError.decodingError {
                logger.error("디코딩중에 에러가 발생했습니다.")
            } catch {
                logger.error("원인 모를 에러가 발생했습니다.")
            }

            return responseData
        }

        switch await task.result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
}

enum FetchError: Error {
    case decodingError
}
