//
//  HabitData.swift
//  Habits
//
//  Created by Kevin on 8/02/21.
//

import Foundation

class HabitData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("habits.data")
    }
    
    @Published var habits: [Habit] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.habits = Habit.data
                }
                #endif
                return
            }
            
            guard let habits = try? JSONDecoder().decode([Habit].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            
            DispatchQueue.main.async {
                self?.habits = habits
            }

        }
    }
    
    func save() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let scrums = self?.habits else { fatalError("Self out of scope") }
                guard let data = try? JSONEncoder().encode(scrums) else { fatalError("Error encoding data") }
                do {
                    let outfile = Self.fileURL
                    try data.write(to: outfile)
                } catch {
                    fatalError("Can't write to file")
                }
            }
        }
}
