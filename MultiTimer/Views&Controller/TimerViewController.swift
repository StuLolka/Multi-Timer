//
//  ViewController.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

class TimerViewController: UIViewController {
    
    internal let nameError = "Имена должны различаться!"
    
    public var timer: Timer?
    
    public var taskArray: [Task] = [] {didSet {
        taskArray = sortTimersByTime(messagesArray: taskArray)
        timersTableView.reloadData()}}
    
    private lazy var views = Views()
    
    internal var isButtonTapped = false
    
    internal let idCell = "identifierCell"
    
    private lazy var addingTimerLabel = views.addingTimerLabel
    
    internal lazy var nameTimerTextField = views.nameTimerTextField
    
    internal lazy var timeInSecTextField = views.timeInSecTextField
    
    private lazy var addButton = views.addButton
    
    private lazy var timersTableView = views.timersTableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Мульти таймер"
        addButton.addTarget(self, action: #selector(dismissKeyboardAndAction), for: .touchUpInside)
        timersTableView.register(CustomCell.self, forCellReuseIdentifier: idCell)
        addConstraints()
        addTappedAround()
        delegateAndDataSource()
    }
    
    private func delegateAndDataSource() {
        timersTableView.delegate = self
        timersTableView.dataSource = self
        nameTimerTextField.delegate = self
        timeInSecTextField.delegate = self
    }
    
    private func addTappedAround() {
        let tappedAround = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAndAction))
        view.addGestureRecognizer(tappedAround)
    }
    
    //MARK: - adding constraints
    private func addConstraints() {
        view.addSubview(addingTimerLabel)
        view.addSubview(nameTimerTextField)
        view.addSubview(timeInSecTextField)
        view.addSubview(addButton)
        view.addSubview(timersTableView)
        NSLayoutConstraint.activate([
            addingTimerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            addingTimerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            addingTimerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            nameTimerTextField.topAnchor.constraint(equalTo: addingTimerLabel.bottomAnchor, constant: 30),
            nameTimerTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            nameTimerTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            timeInSecTextField.topAnchor.constraint(equalTo: nameTimerTextField.bottomAnchor, constant: 15),
            timeInSecTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            timeInSecTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            addButton.topAnchor.constraint(equalTo: timeInSecTextField.bottomAnchor, constant: 30),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            timersTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 30),
            timersTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            timersTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            timersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    //MARK: - sort timers
    private func sortTimersByTime(messagesArray: [Task]) -> [Task] {
        
        let arrayWillReturn = taskArray.sorted { (secondsLeft1, secondsLeft2) -> Bool in
            let secondsLeft1 = secondsLeft1.secondsLeft
            let secondsLeft2 = secondsLeft2.secondsLeft
            return secondsLeft1 > secondsLeft2
        }
        return arrayWillReturn
    }
    
    @objc func dismissKeyboardAndAction(sender: Any) {
        view.endEditing(true)
        if sender as? NSObject == addButton {
            guard let name = nameTimerTextField.text else {return }
            guard let time = timeInSecTextField.text else {return }
            guard name != nameError else {return }
            guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "", time.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
                if name.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    nameTimerTextField.layer.borderColor = UIColor.red.cgColor
                }
                if time.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    timeInSecTextField.layer.borderColor = UIColor.red.cgColor
                }
                return
            }
            
            var count = 0
            while count < taskArray.count { //checking for identical names
                if taskArray[count].name == name {
                    nameTimerTextField.text = nameError
                    nameTimerTextField.layer.borderColor = UIColor.red.cgColor
                    return
                }
                count += 1
            }
            guard time != "0" else {
                timeInSecTextField.layer.borderColor = UIColor.red.cgColor
                return }
            guard let seconds = Int(time) else {return }
            nameTimerTextField.text = ""
            timeInSecTextField.text = ""
            createTimer()
            DispatchQueue.main.async {
                let task = Task(name: name, timeLeft: seconds)
                self.taskArray.append(task)
            }
            
        }
    }
    
    //MARK: - create timer
    private func createTimer() {
        if timer == nil {
            let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    //MARK: - turn off timer
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateTimer() {
        guard let visibleRowsIndexPaths = timersTableView.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleRowsIndexPaths {
            if let cell = timersTableView.cellForRow(at: indexPath) as? CustomCell {
                cell.updateTime()
                if taskArray[indexPath.row].completed {
                    taskArray.remove(at: indexPath.row)
                }
                if taskArray.count == 0 {
                    cancelTimer()
                }
            }
        }
    }
}

