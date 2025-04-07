//
//  CatBreedDetailViewModel.swift
//  challenge_pragma_ios
//
//  Created by Mac on 7/04/25.
//

import Foundation

final class CatBreedDetailViewModel {

    private let breed: CatBreed

    init(breed: CatBreed) {
        self.breed = breed
    }

    var name: String {
        breed.name
    }

    var origin: String {
        breed.origin
    }

    var intelligence: String {
        "\(breed.intelligence)"
    }

    var imageUrl: String? {
        breed.imageUrl
    }

    var description: String {
        breed.description ?? "No description available."
    }

    var lifeSpan: String {
        breed.lifeSpan ?? "Unknown"
    }

    var adaptability: String {
        "\(breed.adaptability ?? 0)/5"
    }
}
