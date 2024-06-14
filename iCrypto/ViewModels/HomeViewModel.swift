//
//  HomeViewModel.swift
//  iCrypto
//
//  Created by Luan Cabral on 20/01/24.
//

import Foundation

protocol HomeViewModelViewDelegate: AnyObject {
    func reloadData()
    func showError(_ alertData: AlertModel)
}

final class HomeViewModel {
    private let service: CoinServiceProtocol
    private(set) var coins: [Coin] = []
    weak var delegate: HomeViewModelViewDelegate?
    
    init(service: CoinServiceProtocol) {
        self.service = service
    }
    
    func fetchCoins() {
        service.fetchCoins(with: .fetchCoins(currency: "CAD")) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coins):
                self.coins = coins.data
                delegate?.reloadData()
            case .failure(let error):
                let alertData = handleAlert(error: error)
                delegate?.showError(alertData)
            }
        }
    }
    
    private func handleAlert(error: CoinServiceError) -> AlertModel {
        var title: String
        var message: String
        
        switch error {
        case .serverError(let statusError):
            title = "Server error: \(statusError.status.code)"
            message = statusError.status.message
        case .unknown(let string):
            title = "Error fetch coin"
            message = string
        case .decodingError(let string):
            title = "Error Parsing Data"
            message = string
        }
        
        return AlertModel(title: title, message: message)
    }
}
