//
//  CatBreedsViewModelTests.swift
//  challenge_pragma_ios
//
//  Created by Mac on 7/04/25.
//
import XCTest
@testable import challenge_pragma_ios

final class CatBreedsViewModelTests: XCTestCase {

    func test_fetchBreeds_success() {
        // Given
        let expected = [
            CatBreed(
                id: "siam",
                name: "Siamese",
                origin: "Thailand",
                intelligence: 5,
                imageUrl: nil,
                description: "Sociable and intelligent.",
                lifeSpan: "12 - 15",
                adaptability: 5
            ),
            CatBreed(
                id: "pers",
                name: "Persian",
                origin: "Iran",
                intelligence: 3,
                imageUrl: nil,
                description: "Calm and affectionate.",
                lifeSpan: "10 - 17",
                adaptability: 4
            )
        ]

        let mockRepository = MockSuccessRepository(breeds: expected)
        let viewModel = CatBreedsViewModel(repository: mockRepository)
        let expectation = self.expectation(description: "fetch breeds")

        // When
        viewModel.onDataUpdated = {
            expectation.fulfill()
        }
        viewModel.fetchBreeds()

        waitForExpectations(timeout: 1.0)

        // Then
        XCTAssertEqual(viewModel.numberOfBreeds(), 2)
        XCTAssertEqual(viewModel.breed(at: 0).name, "Siamese")
    }

    func test_fetchBreeds_failure() {
        // Given
        let mockRepository = MockFailureRepository()
        let viewModel = CatBreedsViewModel(repository: mockRepository)
        let expectation = self.expectation(description: "fetch breeds fail")

        // When
        viewModel.onError = { _ in
            expectation.fulfill()
        }
        viewModel.fetchBreeds()

        waitForExpectations(timeout: 1.0)

        // Then
        XCTAssertEqual(viewModel.numberOfBreeds(), 0)
    }
}

final class MockSuccessRepository: CatBreedRepository {
    private let mockBreeds: [CatBreed]

    init(breeds: [CatBreed]) {
        self.mockBreeds = breeds
    }

    func getAllBreeds(completion: @escaping (Result<[CatBreed], Error>) -> Void) {
        completion(.success(mockBreeds))
    }
}

final class MockFailureRepository: CatBreedRepository {
    func getAllBreeds(completion: @escaping (Result<[CatBreed], Error>) -> Void) {
        completion(.failure(NSError(domain: "MockError", code: -1)))
    }
}
