//
//  InteractorProtocol.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import CoreData

protocol InteractorProtocol {
    var presenter: PresenterProtocol? { get set }
    func getExchange(to: String, from: String, update: NSManagedObjectID?)
    func updateStartTimer()
    func getAllExchangeModelCore() -> [EchangeVieModel]
    func delete(_ iteam: EchangeVieModel)
}
