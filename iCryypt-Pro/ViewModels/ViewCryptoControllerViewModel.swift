//
//  ViewCryptoControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-04-01.
//

import Foundation
import UIKit

class ViewCryptoControllerViewModel {
    
    var onImageLoaded: ((UIImage?)->Void)?
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
        self.loadImage()
    }
    
    private func loadImage() {
        
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }
     
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: \(self.coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.quote.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.quote.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.max_supply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
        }
    }
    
    
}
