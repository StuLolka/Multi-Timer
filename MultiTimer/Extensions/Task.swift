//
//  Task.swift
//  MultiTimer
//
//  Created by Сэнди Белка on 11.07.2021.
//

import Foundation

final class Task {
    public let name: String
    public var secondsLeft: Int
    public var completed = false
    
    init(name: String, timeLeft: Int) {
        self.name = name
        self.secondsLeft = timeLeft
    }
}
