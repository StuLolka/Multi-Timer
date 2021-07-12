//
//  ExtensionTimerViewController.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height / 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as? CustomCell else {return UITableViewCell()}
        cell.task = taskArray[indexPath.row]
        cell.pauseButton.addTarget(self, action: #selector(TimerViewController.stopStartTimer), for: .touchUpInside)
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Таймеры"
    }
    
    @objc func stopStartTimer(sender: ExtraPropertyButton) {
        sender.isPressed = !sender.isPressed
        switch sender.isPressed {
        case true:
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        case false:
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
        }
        
    }
}



