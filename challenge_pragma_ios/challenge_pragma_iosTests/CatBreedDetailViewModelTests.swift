//
//  CatBreedDetailViewModelTests.swift
//  challenge_pragma_ios
//
//  Created by Mac on 7/04/25.
//
import XCTest
@testable import challenge_pragma_ios

final class CatBreedDetailViewModelTests: XCTestCase {

    func test_viewModel_exposes_expected_properties() {
        // Given
        let breed = CatBreed(
            id: "maine",
            name: "Maine Coon",
            origin: "USA",
            intelligence: 4,
            imageUrl: "http://image.url",
            description: "Large and friendly cat.",
            lifeSpan: "9 - 15",
            adaptability: 4
        )
        let viewModel = CatBreedDetailViewModel(breed: breed)

        // Then
        XCTAssertEqual(viewModel.name, "Maine Coon")
        XCTAssertEqual(viewModel.origin, "USA")
        XCTAssertEqual(viewModel.intelligence, "4")
        XCTAssertEqual(viewModel.imageUrl, "http://image.url")
    }
}

