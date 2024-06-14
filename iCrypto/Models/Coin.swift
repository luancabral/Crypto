//
//  Coin.swift
//  iCrypto
//
//  Created by Luan Cabral on 13/01/24.
//

import Foundation

struct CoinList: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let name: String
    let maxSupply: Double?
    let rank: Int
    let quote: PricingData
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, quote
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
    }
}

struct PricingData: Decodable {
    let CAD: CAD
}

struct CAD: Decodable {
    let price: Double
    let marketCap: Double
    
    private enum CodingKeys: String, CodingKey {
        case price
        case marketCap = "market_cap"
    }
}
