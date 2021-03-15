//
//  HabitList.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI

struct HabitList: View {
    @Binding var habits: [Habit]
    @State private var isPresented = false
    @State private var newHabit = Habit.Data()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    var body: some View {
        List{
            ForEach(habits) { habit in
                NavigationLink(destination: DetailView(habit: binding(for: habit))) {
                    CardView(habit: habit)
                }
                .listRowBackground(habit.color)
            }
            .onDelete { indices in
                habits.remove(atOffsets: indices)
            }
        }
        .lineSpacing(100.0)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("My activities")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(habitData: $newHabit)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let new = Habit(title: newHabit.title, lengthInMinutes: Int(newHabit.lengthInMinutes), color: newHabit.color, momentOfDay: newHabit.momentOfDay, tasks: newHabit.tasks)
                        habits.append(new)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    private func binding(for habit: Habit) -> Binding<Habit> {
        guard let habitIndex = habits.firstIndex(where: { $0.id == habit.id }) else {
            fatalError("Can't find scrum in array")
        }
        
        return $habits[habitIndex]
    }
}

struct HabitList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HabitList(habits: .constant(Habit.data), saveAction: {})
        }
    }
}
