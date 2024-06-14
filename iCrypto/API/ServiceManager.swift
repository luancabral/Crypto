//
//  ServiceManager.swift
//  iCrypto
//
//  Created by Luan Cabral on 04/03/24.
//

import Foundation

class ServiceManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get<T: Decodable>(with endPoint: Endpoint, dataType: T.Type, completion: @escaping (Result<T, CoinServiceError>) -> Void){
        guard let request = endPoint.request else { return }
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                do {
                    let mappedErro = try JSONDecoder().decode(StatusError.self, from: data ?? Data())
                    completion(.failure(.serverError(mappedErro)))
                } catch {
                    completion(.failure(.unknown()))
                }
            }
            
            if let data = data {
                do {
                    let coinList = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(coinList))
                } catch {
                    completion(.failure(.decodingError()))
                }
            } else {
                completion(.failure(.unknown()))
            }
        }.resume()
    }
}
