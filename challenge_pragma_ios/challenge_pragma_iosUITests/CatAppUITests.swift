//
//  CatAppUITests.swift
//  challenge_pragma_ios
//
//  Created by Mac on 7/04/25.
//

import XCTest

final class CatAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func test_tapBreedCell_navigatesToDetail() {
        // Given
        let tableView = app.tables.element(boundBy: 0)
        let firstCell = tableView.cells.element(boundBy: 0)

        // When
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10))
        firstCell.tap()

        // Then
        let originLabel = app.staticTexts["originLabel"]
        XCTAssertTrue(originLabel.waitForExistence(timeout: 5))
    }

    
    
}
