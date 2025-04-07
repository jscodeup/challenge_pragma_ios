//
//  CatBreedRepositoryImpl.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import Foundation

final class CatBreedRepositoryImpl: CatBreedRepository {

    private let remoteDataSource: CatBreedRemoteDataSource

    init(remoteDataSource: CatBreedRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getAllBreeds(completion: @escaping (Result<[CatBreed], Error>) -> Void) {
        remoteDataSource.fetchBreeds(completion: completion)
    }
}
