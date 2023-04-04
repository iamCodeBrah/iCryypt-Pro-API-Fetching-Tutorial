//
//  HomeControllerViewModel.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-04-01.
//

import UIKit

class HomeControllerViewModel {
    
    // MARK: - Callbacks
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    // MARK: - Variables
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private(set) var filteredCoins: [Coin] = []
    
    // MARK: - Initializer
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
        
    }
}

// MARK: - Search
extension HomeControllerViewModel {
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = allCoins

        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
            
            self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText) })
        }
        
        self.onCoinsUpdated?()
    }
}
