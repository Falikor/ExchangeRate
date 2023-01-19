//
//  PresenterProtocol.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation

protocol PresenterProtocol {
    var router: RouterProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var view: ExchangeViewProtocol? { get set }

    func interactorFetchExchange(with result: Result<[EchangeVieModel], Error>)
    func getEchangeVieModel() -> [EchangeVieModel]
    func delete(_ iteam: EchangeVieModel)
    func openChoseExchange()
    func startTaimer()
}
