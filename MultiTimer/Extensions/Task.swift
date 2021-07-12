//
//  Task.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 11.07.2021.
//

import Foundation

final class Task {
    public let name: String
    public var timeLeft: Int
    public var completed = false
    public let creationDate = Date()
    
    init(name: String, timeLeft: Int) {
        self.name = name
        self.timeLeft = timeLeft
    }
}
