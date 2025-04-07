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
    let image: ImageDTO?

    struct ImageDTO: Decodable {
        let url: String
    }

    func toDomain() -> CatBreed {
        return CatBreed(
            id: id,
            name: name,
            origin: origin,
            intelligence: intelligence,
            imageUrl: image?.url
        )
    }
}
