// statusCode는 Request과정에서 확인 가능하므로 추가하지 않았습니다.
protocol Meal {
    var body: [MealDetails] { get set }
}

struct MealType: Decodable, Meal {
    var body: [MealDetails]
}

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

enum DeliveryType: String, Decodable {
    case dawnDelivery       = "새벽배송"
    case everyWhereDelivery = "전국택배"
}

enum Badge: String, Decodable {
    case best       = "BEST"
    case new        = "NEW"
    case eventSale  = "이벤트특가"
    case seasonSale = "계절특가"
    case todaySale  = "오늘특가"
}
