//
//  CatBreedRemoteDataSource.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import Foundation

final class CatBreedRemoteDataSource {

    private let apiKey = "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr"

    func fetchBreeds(completion: @escaping (Result<[CatBreed], Error>) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/breeds"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1)))
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "EmptyData", code: -2)))
                return
            }

            do {
                let response = try JSONDecoder().decode([CatBreedResponseDTO].self, from: data)
                let breeds = response.map { $0.toDomain() }
                completion(.success(breeds))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
