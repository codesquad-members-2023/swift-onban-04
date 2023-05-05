//  Created by 1 on 2023/05/05.

enum Badge: String, Decodable {
    case best       = "BEST"
    case new        = "NEW"
    case eventSale  = "이벤트특가"
    case seasonSale = "계절특가"
    case todaySale  = "오늘특가"
}
