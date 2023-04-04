//
//  HomeControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-04-01.
//

import Foundation

class HomeControllerViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    init() {
        self.fetchCoins()
        
//        self.coins.insert(Coin(id: <#T##Int#>, name: <#T##String#>, maxSupply: <#T##Int?#>, rank: <#T##Int#>, pricingData: <#T##PricingData#>, logoURL: <#T##URL?#>), at: <#T##Int#>)
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
        
    }
}
