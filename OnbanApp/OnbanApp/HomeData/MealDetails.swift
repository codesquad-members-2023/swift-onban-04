//  Created by wood on 2023/05/05.

import Foundation

// alt 변수는 title과 내용이 동일하므로 추가하지 않았습니다.
struct MealDetails: Decodable {
    let detailHash: String
    let image: String
    let deliveryType: [DeliveryType]
    let title: String
    let description: String
    let price: String?
    let sellPrice: String
    let badge: [Badge]?

    enum CodingKeys: String, CodingKey {
        case detailHash     = "detail_hash"
        case image
        case deliveryType   = "delivery_type"
        case title
        case description
        case price          = "n_price"
        case sellPrice      = "s_price"
        case badge
    }
}
