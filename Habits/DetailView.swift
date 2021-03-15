//
//  DetailView.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI

struct DetailView: View {
    @Binding var habit: Habit
    @State private var data: Habit.Data = Habit.Data()
    @State private var isPresented = false
    
    var body: some View {
        List{
            Section(header: Text("Habit Info")) {
                NavigationLink(destination: HabitView(habit: $habit)){
                    Label("Start habit", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(habit.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(habit.color)
                }
                HStack {
                    Label("Times", systemImage: "leaf.fill")
                    Spacer()
                    Image(systemName: habit.momentOfDay.rawValue)
                }
                
            }
            Section(header: Text("Tasks")) {
                if habit.tasks.isEmpty {
                    Text("No tasks applied")
                }
                    
                ForEach(habit.tasks, id: \.self) { task in
                    Label(task, systemImage: "checkmark.shield")
                }
            }
            Section(header: Text("History")) {
                if habit.history.isEmpty {
                    Text("No recoreds")
                }
                
                ForEach(habit.history) { history in
                    HStack {
                        Image(systemName: "shield.fill")
                            .foregroundColor(.accentColor)
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = habit.emptyData
        })
        .navigationTitle(habit.title)
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView(habitData: $data)
                    .navigationTitle(habit.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        isPresented = false
                        habit.update(from: data)
                    })
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(habit: .constant(Habit.data[0]))
        }
    }
}
