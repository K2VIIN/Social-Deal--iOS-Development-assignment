struct DealResponse: Codable {
    let num_deals: Int
    let deals: [Deal]
}

struct Deal: Codable, Equatable {
    let unique: String
    let title: String
    let image: String
    let soldLabel: String
    let company: String
    let city: String
    let prices: Prices
    
    enum CodingKeys: String, CodingKey {
        case unique, title, image
        case soldLabel = "sold_label"
        case company, city, prices
    }
    
    static func ==(lhs: Deal, rhs: Deal) -> Bool {
        return lhs.unique == rhs.unique
    }
}

struct Prices: Codable {
    let price: Price?
    let fromPrice: Price?
    let priceLabel: String?
    let discountLabel: String?
    
    enum CodingKeys: String, CodingKey {
        case price
        case fromPrice = "from_price"
        case priceLabel = "price_label"
        case discountLabel = "discount_label"
    }
}

struct Price: Codable {
    let amount: Double?
    let currency: Currency
}

struct Currency: Codable {
    let symbol: String
    let code: String
}
