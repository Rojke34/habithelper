//
//  HabitsApp.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI

@main
struct HabitsApp: App {
    @ObservedObject private var data = HabitData()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HabitList(habits: $data.habits) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
