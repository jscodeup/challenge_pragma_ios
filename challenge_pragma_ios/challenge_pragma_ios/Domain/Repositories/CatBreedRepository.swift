//
//  CatBreedRepository.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import Foundation

protocol CatBreedRepository {
    func getAllBreeds(completion: @escaping (Result<[CatBreed], Error>) -> Void)
}
