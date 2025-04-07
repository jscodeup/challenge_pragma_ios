//
//  CatBreedsViewModel.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import Foundation

final class CatBreedsViewModel {

    private let repository: CatBreedRepository
    private(set) var allBreeds: [CatBreed] = []
    private(set) var filteredBreeds: [CatBreed] = []

    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(repository: CatBreedRepository) {
        self.repository = repository
    }

    func fetchBreeds() {
        repository.getAllBreeds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let breeds):
                    self?.allBreeds = breeds
                    self?.filteredBreeds = breeds
                    self?.onDataUpdated?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }

    func filterBreeds(query: String) {
        guard !query.isEmpty else {
            filteredBreeds = allBreeds
            onDataUpdated?()
            return
        }

        filteredBreeds = allBreeds.filter {
            $0.name.lowercased().contains(query.lowercased())
        }
        onDataUpdated?()
    }

    func breed(at index: Int) -> CatBreed {
        return filteredBreeds[index]
    }

    func numberOfBreeds() -> Int {
        return filteredBreeds.count
    }
}
