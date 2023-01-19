//
//  ChildViewController.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import UIKit

class СurrenciesViewController: UIViewController, СurrenciesViewProtocol, UIPickerViewDelegate, UIPickerViewDataSource {
    var presentr: СurrenciesPresenterProtocol?
    let picker = UIPickerView()
    var allCase: [String]?

    private let buttonView: UIButton = {
        let button = UIButton()
        button.setTitle("Отслеживать валютуню пару", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(.none, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        picker.dataSource = self
        picker.delegate = self
        view.addSubview(picker)
        view.addSubview(buttonView)
        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }

    // MARK: Action
    @objc
    private func buttonAction() {
        let indexTo = picker.selectedRow(inComponent: 0)
        let indexFrom = picker.selectedRow(inComponent: 1)
        presentr?.getExchange(to: allCase?[indexTo], from: allCase?[indexFrom])
    }

    // MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCase?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return allCase?[row]
        } else {
            return allCase?[row]
        }
    }

    // MARK: Constraints
    func setupConstraints() {
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 300).isActive = true
        picker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        picker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
    }
    
    // MARK: Alert
    func alertError() {
        let alert = UIAlertController(title: "Ошибка", message: "Нельзя выбирать одни и теже валюты или те валюты что вы отслеживайте", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension СurrenciesViewController {
    // MARK: Отслеживаю загрузилось ли в CoreData новое значение
    func updateExchange(with exchange: ExchangeModelCore) {
        DispatchQueue.main.async {
            self.presentr?.update()
        }

    }
    // MARK: Отслеживаю загрузилось ли все валюты
    func updateAllCurrency(with allCurrency: [String]?) {
        DispatchQueue.main.async {
            self.allCase = allCurrency
            self.picker.reloadAllComponents()
        }
    }
    // MARK: Отслеживаю выполнение тех условий
    func updateExchangeError(with error: String) {
        DispatchQueue.main.async {
            self.alertError()
        }
    }
}
