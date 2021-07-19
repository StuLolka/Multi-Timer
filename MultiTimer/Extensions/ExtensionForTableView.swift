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
        getImage(sender: cell.pauseButton, condition: cell.task?.isPaused ?? false)
        cell.startStop = { sender in
            guard let task = cell.task else {return }
            task.isPaused = !task.isPaused
            self.getImage(sender: sender, condition: task.isPaused)
        }

        cell.delete = { sender in
            cell.task?.completed = true
        }
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("header title", comment: "")
    }
    

    
    //MARK: -change image for pause button
    private func getImage(sender: UIButton, condition: Bool) {
        switch condition {
        case true:
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        case false:
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
        }
        
    }
}



