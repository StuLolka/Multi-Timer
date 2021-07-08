//
//  CustomCell.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let pauseButton: UIButton = {
        let but = UIButton()
        but.setImage(UIImage(systemName: "pause"), for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    public let timeLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
            timeLeftLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
    }
}
