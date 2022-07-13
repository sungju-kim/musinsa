//
//  NetworkManager.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()

    func request<T: Decodable>(endPoint: Requestable, completion: @escaping (Result<T, NetworkError>) -> Void ) {
        guard let url = endPoint.url else {
            completion(.failure(.invalidUrl))
            return
        }

        let request = AF.request(url,
                                 method: endPoint.method,
                                 parameters: endPoint.parameter,
                                 headers: endPoint.headers)

        request
            .validate(statusCode: 200..<300)
            .response { response in
                guard let data = response.data else {
                    completion(.failure(.emptyData))
                    return
                }

                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.failToDecode))
                    return
                }

                completion(.success(decodedData))
            }
    }
}
