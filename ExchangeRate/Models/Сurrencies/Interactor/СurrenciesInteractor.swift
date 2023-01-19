//
//  СurrenciesInteractor.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation

class СurrenciesInteractor: СurrenciesInteractorProtocol {
    var presenter: СurrenciesPresenterProtocol?
    var allCurrency: [String: String] = [:]
    var echangeCoreModels: [EchangeVieModel] = []

    func getExchange(to: String?, from: String?) {
        guard let to = to, let from = from else {
            self.presenter?.interactorFetchExchange(with: .failure(FetchError.failed))
            return
        }
        guard checkForDuplicate(to: to, from: from) == false else {
            self.presenter?.interactorFetchExchange(with: .failure(FetchError.failed))
            return
        }
        let stringUrl = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=1"
        guard let url = URL(string: stringUrl) else { return }
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("6oUb6vRbDTN70tgHXr7vtWNccjWrJ9yD", forHTTPHeaderField: "apikey")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorFetchExchange(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode(EchangeNetworkModel.self, from: data)
                guard let to = entities.query?.to else { return }
                guard let from = entities.query?.from else { return }
                guard let result = entities.result else { return }

                let echangeCoreModel = ExchangeModelCore(context: CoreDataManager.shared.viewContext)
                echangeCoreModel.to = to
                echangeCoreModel.subTitelTo = self?.allCurrency[to]
                echangeCoreModel.from = from
                echangeCoreModel.subTitelFrom = self?.allCurrency[from]
                echangeCoreModel.result = result
                echangeCoreModel.exchangeUpDown = ExchangeUpDown.blue.rawValue
                CoreDataManager.shared.save()

                self?.presenter?.interactorFetchExchange(with: .success(echangeCoreModel))
            } catch {
                self?.presenter?.interactorFetchExchange(with: .failure(error))
            }
        }
        task.resume()
    }

    func getAllCurrency() {
         let stringUrl = "https://api.apilayer.com/exchangerates_data/symbols"
         guard let url = URL(string: stringUrl) else { return }
         var request = URLRequest(url: url,timeoutInterval: Double.infinity)
         request.httpMethod = "GET"
         request.addValue("6oUb6vRbDTN70tgHXr7vtWNccjWrJ9yD", forHTTPHeaderField: "apikey")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorFetchAllCurrency(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode(AllCurrency.self, from: data)
                self?.allCurrency = entities.symbols ?? [:]
                let result = entities.symbols?.map {$0.key}
                self?.presenter?.interactorFetchAllCurrency(with: .success(result))
            } catch {
                self?.presenter?.interactorFetchAllCurrency(with: .failure(error))
            }
        }
        task.resume()
    }

    func checkForDuplicate(to: String, from: String) -> Bool {
        var check = false
        getAllExchangeModelCore()
        guard to != from else { return true }
        guard !to.isEmpty || !from.isEmpty else { return true}
        echangeCoreModels.forEach {
            if $0.from == from && $0.to == to {
                check = true
            }
        }
        return check
    }

    func getAllExchangeModelCore() {
        echangeCoreModels = CoreDataManager.shared.getAllExchangeModelCore().map(EchangeVieModel.init)
    }
}
