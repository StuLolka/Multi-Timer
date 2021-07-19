//
//  Views.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

final class Views {
    public let addingTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.text = NSLocalizedString("add timers", comment: "")
        return label
    }()

    public let nameTimerTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("timer name", comment: "")
        textField.backgroundColor = UIColor(named: "BackgroundTextFieldColor")
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()

    public let timeInSecTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("time in seconds", comment: "")
        textField.backgroundColor = UIColor(named: "BackgroundTextFieldColor")
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .numberPad
        return textField
    }()

    public let addButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle(NSLocalizedString("add button title", comment: ""), for: .normal)
        but.backgroundColor = UIColor(named: "BackgroundAddButton")
        but.setTitleColor(.systemBlue, for: .normal)
        but.layer.cornerRadius = 10
        return but
    }()

    public let timersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "BackgroundTableView")
        tableView.separatorStyle = .none
        return tableView
    }()
}

