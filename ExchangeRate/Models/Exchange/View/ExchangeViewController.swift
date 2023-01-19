//
//  View.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import UIKit

class ExchangeViewController: UIViewController, ExchangeViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var presentr: PresenterProtocol?

    private let tableView: UITableView = {
        let tabelExchange = UITableView()
        tabelExchange.register(CustomTableViewCell.self, forCellReuseIdentifier: "сustom")
        tabelExchange.rowHeight = 60
        tabelExchange.isHidden = true
        return tabelExchange
    }()
    private let buttonView: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить валютуню пару", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(.none, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    var echangeModel: [EchangeVieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Курсы валютных пар"
        view.addSubview(tableView)
        view.addSubview(buttonView)
        getAllExchangeModelCore()
        tableView.delegate = self
        tableView.dataSource = self

        presentr?.startTaimer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllExchangeModelCore()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        setupConstraints()
    }

    @objc
    private func buttonAction() {
        presentr?.openChoseExchange()
    }

    func updateExchange(with exchange: [EchangeVieModel]) {
        DispatchQueue.main.async {
            self.echangeModel = exchange
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.presentr?.startTaimer()
        }
    }

    func getAllExchangeModelCore() {
        DispatchQueue.main.async {
            self.echangeModel = self.presentr?.getEchangeVieModel() ?? []
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }

    func updateExchangeError(with error: String) {
        
    }

// MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return echangeModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "сustom", for: indexPath) as! CustomTableViewCell
        cell.labTo.text = echangeModel[indexPath.row].to
        cell.labToSubtitle.text = echangeModel[indexPath.row].subTitelTo
        cell.labResult.text = echangeModel[indexPath.row].result.description
        cell.labFrom.text = echangeModel[indexPath.row].from
        cell.labFromSubtitle.text = echangeModel[indexPath.row].subTitelFrom
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presentr?.delete(echangeModel[indexPath.row])
            self.echangeModel.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // MARK: Constraints
    func setupConstraints() {
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
    }
}

