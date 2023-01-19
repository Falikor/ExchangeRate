//
//  CustomTableViewCell.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    var labTo = UILabel()
    var labToSubtitle = UILabel()
    var labResult = UILabel()
    var labFrom = UILabel()
    var labFromSubtitle = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        labTo.translatesAutoresizingMaskIntoConstraints = false
        labToSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labToSubtitle.font = UIFont.systemFont(ofSize: 12)
        labToSubtitle.textColor = .gray
        labResult.translatesAutoresizingMaskIntoConstraints = false
        labFrom.translatesAutoresizingMaskIntoConstraints = false
        labFromSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labFromSubtitle.font = UIFont.systemFont(ofSize: 12)
        labFromSubtitle.textColor = .gray
        labFromSubtitle.numberOfLines = 0

        contentView.addSubview(labTo)
        contentView.addSubview(labToSubtitle)
        contentView.addSubview(labResult)
        contentView.addSubview(labFrom)
        contentView.addSubview(labFromSubtitle)


        NSLayoutConstraint.activate([
            labTo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labTo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            labTo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labTo.heightAnchor.constraint(equalToConstant: 20),

            labToSubtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labToSubtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            labToSubtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labToSubtitle.heightAnchor.constraint(equalToConstant: 30),

            labResult.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -40),
            labResult.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            labResult.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labResult.heightAnchor.constraint(equalToConstant: 20),

            labFrom.leadingAnchor.constraint(equalTo: labTo.trailingAnchor, constant: -100),
            labFrom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            labFrom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labFrom.heightAnchor.constraint(equalToConstant: 20),

            labFromSubtitle.leadingAnchor.constraint(equalTo: labResult.trailingAnchor, constant: -100),
            labFromSubtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            labFromSubtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            labFromSubtitle.heightAnchor.constraint(equalToConstant: 30)

        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
