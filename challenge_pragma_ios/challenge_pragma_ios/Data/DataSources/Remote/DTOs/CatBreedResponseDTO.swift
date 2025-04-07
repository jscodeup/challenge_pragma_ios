//
//  CatBreedResponseDTO.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import Foundation

struct CatBreedResponseDTO: Decodable {
    let id: String
    let name: String
    let origin: String
    let intelligence: Int
    let referenceImageId: String?
    let description: String?
    let lifeSpan: String?
    let adaptability: Int?

    private enum CodingKeys: String, CodingKey {
        case id, name, origin, intelligence, description, adaptability
        case lifeSpan = "life_span"
        case referenceImageId = "reference_image_id"
    }

    func toDomain() -> CatBreed {
        let imageUrl = referenceImageId.map {
            "https://cdn2.thecatapi.com/images/\($0).jpg"
        }

        return CatBreed(
            id: id,
            name: name,
            origin: origin,
            intelligence: intelligence,
            imageUrl: imageUrl,
            description: description,
            lifeSpan: lifeSpan,
            adaptability: adaptability
        )
    }
}
