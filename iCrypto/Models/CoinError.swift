//
//  CoinError.swift
//  iCrypto
//
//  Created by Luan Cabral on 20/01/24.
//

import Foundation

struct StatusError: Decodable {
    let status: CoinError
}

struct CoinError: Decodable {
    let code: Int
    let message: String
    
    private enum CodingKeys: String, CodingKey {
//        case status
        case code = "error_code"
        case message = "error_message"
    }
    
//    init (from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let status = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .status)
//
//        self.code = try status.decode(Int.self, forKey: .code)
//        self.message = try status.decode(String.self, forKey: .message)
//    }
}
