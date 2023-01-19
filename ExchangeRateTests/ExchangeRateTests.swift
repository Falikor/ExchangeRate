//
//  ExchangeRateTests.swift
//  ExchangeRateTests
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import XCTest
@testable import ExchangeRate

final class ExchangeRateTests: XCTestCase {

    var sut: СurrenciesInteractorMock!
    var presenter: СurrenciesPresenter!
    var view: СurrenciesViewController!

    override func setUp() {
        super.setUp()
        presenter = СurrenciesPresenter()
        sut = СurrenciesInteractorMock()
        view = СurrenciesViewController()
        view.presentr = presenter
        presenter.interactor = sut
        presenter.view = view
        sut.presenter = presenter
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        sut = nil
        view = nil
    }

    func test_loaded_all_currency() throws {
        sut.getAllCurrency()
        let exp = expectation(description: "Loaded all currencys")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        guard let result = view.allCase else { return }
        XCTAssertTrue(!result.isEmpty)
    }

    func test_PerformanceExample() {
        let presenterMock = СurrenciesPresenterMock()
        sut.presenter = presenterMock
        presenterMock.view = view
        view.presentr = presenterMock
        presenterMock.interactor = sut
        sut.getExchange(to: "", from: "")
        let exp = expectation(description: "Loaded all exchange")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertTrue(presenterMock.result)
    }

}
