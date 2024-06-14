//
//  CoinService.swift
//  iCrypto
//
//  Created by Luan Cabral on 20/01/24.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(StatusError)
    case unknown(String = "An unkown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

protocol CoinServiceProtocol {
    func fetchCoins(with endpoint: Endpoint,
                    completion: @escaping (Result<CoinList, CoinServiceError>) -> Void)
}

final class CoinService: CoinServiceProtocol {
    let serviceManager = ServiceManager()
    
    func fetchCoins(with endpoint: Endpoint,
                    completion: @escaping (Result<CoinList, CoinServiceError>) -> Void) {
        serviceManager.get(with: endpoint, dataType: CoinList.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
