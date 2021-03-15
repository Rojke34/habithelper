//
//  History.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var tasks: [String]
    var lengthInMinutes: Int

    init(id: UUID = UUID(), date: Date = Date(), tasks: [String], lengthInMinutes: Int) {
        self.id = id
        self.date = date
        self.tasks = tasks
        self.lengthInMinutes = lengthInMinutes
    }
}
