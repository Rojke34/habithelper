//
//  Habit.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    let id: UUID
    var title: String
    var lengthInMinutes: Int
    var color: Color
    var momentOfDay: Times
    var tasks: [String]
    var history: [History]
    
    init(id: UUID = UUID(), title: String, lengthInMinutes: Int, color: Color, momentOfDay: Times = .all, tasks: [String] = [], history: [History] = []) {
        self.id = id
        self.title = title
        self.lengthInMinutes = lengthInMinutes
        self.color = color
        self.momentOfDay = momentOfDay
        self.tasks = tasks
        self.history = history
    }
}

extension Habit {
    static var data: [Habit] {
        [
            Habit(title: "Practice Guitar", lengthInMinutes: 30, color: Color("Color One"), momentOfDay: .night, tasks: ["Tune guitar", "Warn Up"]),
            Habit(title: "Ride a bike", lengthInMinutes: 60, color: Color("Color Two"), momentOfDay: .night, tasks: ["Water", "Tools", "Helmet", "Keys"]),
            Habit(title: "Read a book", lengthInMinutes: 30, color: Color("Color Three"), momentOfDay: .afternoon, tasks: ["Tea", "find a good place"]),
            Habit(title: "Practice Kalimba", lengthInMinutes: 30, color: Color("Color One"), momentOfDay: .night, tasks: ["Tune Kalimba", "Warn Up"]),
            Habit(title: "Drink water", lengthInMinutes: 5, color: Color("Color Two"), momentOfDay: .all, tasks: ["Flavoring"]),
            Habit(title: "Practice Painting", lengthInMinutes: 30, color: Color("Color Three"), momentOfDay: .morning, tasks: ["Try", "Try", "Try"]),
            Habit(title: "Go for a walk", lengthInMinutes: 30, color: Color("Color One"), momentOfDay: .morning, tasks: ["Jus walk", "😂", "Jump rope"]),
            Habit(title: "Work on a project", lengthInMinutes: 30, color: Color("Color Two"), momentOfDay: .all, tasks: ["Focus", ""]),
            Habit(title: "Play videogames", lengthInMinutes: 30, color: Color("Color Three"), momentOfDay: .all, tasks: ["Focus", "Enjoy"]),
            Habit(title: "Buy Bitcoins", lengthInMinutes: 30, color: Color("Color One"), momentOfDay: .night, tasks: ["See market", "Be patience"]),
            Habit(title: "Make the bed", lengthInMinutes: 30, color: Color("Color Two"), momentOfDay: .morning, tasks: ["Don't forget", "Always"]),
            Habit(title: "Do fasting", lengthInMinutes: 30, color: Color("Color Three"), momentOfDay: .morning, tasks: ["Be brave"])
        ]
    }
}

extension Habit {
    struct Data {
        var title: String = ""
        var lengthInMinutes: Double = 0.0
        var momentOfDay: Times = .all
        var tasks: [String] = []
        var color: Color = .random
    }
    
    var emptyData: Data {
        return Data(title: title, lengthInMinutes: Double(lengthInMinutes), momentOfDay: momentOfDay, tasks: tasks, color: color)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        lengthInMinutes = Int(data.lengthInMinutes)
        momentOfDay = data.momentOfDay
        tasks = data.tasks
        color = data.color
    }
}

