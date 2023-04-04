//
//  CoinService.swift
//  iCryypt-Pro
//
//  Created by YouTube on 2023-04-01.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

class CoinService {
    
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinServiceError>)->Void) {
        guard let request = endpoint.request else { return }
        
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                    
                } catch let err {
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    completion(.success(coinData.data))
                    
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
                
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
    
}
