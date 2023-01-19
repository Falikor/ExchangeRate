//
//  Interactor.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import CoreData

class ExchangeInteractor: InteractorProtocol {
    var presenter: PresenterProtocol?
    var timer = Timer()
    var echangeCoreModels: [EchangeVieModel] = []

    func getExchange(to: String, from: String, update: NSManagedObjectID? = nil) {
        let stringUrl = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=1"
        guard let url = URL(string: stringUrl) else { return }
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("rDWbRBHc3kPckkdfCvxzX86iaGOMDdgD", forHTTPHeaderField: "apikey")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorFetchExchange(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode(EchangeNetworkModel.self, from: data)
                guard let result = entities.result else { return }

                if let id = update {
                    CoreDataManager.shared.update(id: id, result: result)
                }
                CoreDataManager.shared.save()
                // тут не забуть исправить
                self?.presenter?.interactorFetchExchange(with: .success(self?.getAllExchangeModelCore() ?? []))
            } catch {
                self?.presenter?.interactorFetchExchange(with: .failure(error))
            }
        }
        task.resume()
    }

    func updateStartTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
            self.echangeCoreModels.forEach {
                self.getExchange(to: $0.to, from: $0.from, update: $0.id)
            }
        })
    }

    func getAllExchangeModelCore() -> [EchangeVieModel] {
        echangeCoreModels = CoreDataManager.shared.getAllExchangeModelCore().map(EchangeVieModel.init)
        return echangeCoreModels
    }

    func delete(_ iteam: EchangeVieModel) {
        let echangeCoreModel = CoreDataManager.shared.getExchangeModelCoreById(id: iteam.id)
        if let echangeCoreModel = echangeCoreModel {
            CoreDataManager.shared.deleteExchangeModelCore(item: echangeCoreModel)
        }
    }
}
