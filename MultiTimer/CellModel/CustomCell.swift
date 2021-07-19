//
//  CustomCell.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

final public class CustomCell: UITableViewCell {
    
    var task: Task? {
        didSet {
            nameLabel.text = task?.name
            updateTime()
        }
    }
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy public var pauseButton: UIButton = {
        let but = UIButton()
        but.setImage(UIImage(systemName: "pause"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.isUserInteractionEnabled = true
        but.addTarget(self, action: #selector(test), for: .touchUpInside)
        return but
    }()
    
    public let timeLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    public var buttonAction: ((UIButton) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(pauseButton)
        addSubview(timeLeftLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: pauseButton.leftAnchor, constant: -5),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            pauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: bounds.height * 2/3),
            pauseButton.widthAnchor.constraint(equalTo: heightAnchor),
            
            timeLeftLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            timeLeftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLeftLabel.leftAnchor.constraint(equalTo: pauseButton.rightAnchor, constant: 5)
            
        ])
        
    }
    
    public func updateTime() {
        guard let task = task else {return }
        let secondsLeft = task.secondsLeft
        if secondsLeft <= 0 {
            timeLeftLabel.text = "0"
            task.completed = true
            return
        }
        let days = secondsLeft / 86400
        let hours = secondsLeft / 3600 % 24
        let minutes = secondsLeft / 60 % 60
        let seconds = secondsLeft % 60
        
        var times: [String] = []
        if days > 0 {
            times.append("\(days)d")
        }
        if hours > 0 {
            times.append("\(hours)h")
        }
        if minutes > 0 {
            times.append("\(minutes)m")
        }
        
        times.append("\(seconds)s")
        timeLeftLabel.text = times.joined(separator: " ")
    }
    
    @objc func test(sender: UIButton) {
        buttonAction?(sender)
    }
}

