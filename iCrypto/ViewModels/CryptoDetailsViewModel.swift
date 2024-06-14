//
//  CryptoDetailsViewModel.swift
//  iCrypto
//
//  Created by Luan Cabral on 19/01/24.
//

import Foundation
import UIKit


final class CryptoDetailsViewModel {
    
    var onImageLoaded: ((UIImage?) -> Void)?
    // MARK: - Properties
    let coin: Coin
    
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: \(coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(coin.quote.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(coin.quote.CAD.marketCap)"
    }
    
    var maxSupplyLabel: String {
        let title = "Max Supply:"
        if let maxSupply = coin.maxSupply {
            return "\(title) $\(maxSupply)"
        }
        
        return "\(title) - "
    }
    
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    // MARK: - Methods
    func downloadImage(completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global().async { [weak self] in
            guard let coinUrl = self?.coin.logoURL,
                  let imageData = try? Data(contentsOf: coinUrl) else { return }
            let logoImage = UIImage(data: imageData)
            completion(logoImage)
        }
    }
}
