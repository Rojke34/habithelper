//
//  EditView.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI

enum Times: String, CaseIterable, Encodable, Decodable {
    
    case morning   = "sunrise.fill"
    case afternoon = "sun.max.fill"
    case evening   = "sunset.fill"
    case night     = "moon.fill"
    case all       = "smallcircle.fill.circle"
    
    var id: String { self.rawValue }
}

struct EditView: View {
    
    @Binding var habitData: Habit.Data
    @State private var newTask = ""
    
    var body: some View {
        List {
            Section(header: Text("Habit Info")) {
                TextField("Title", text: $habitData.title)
                HStack {
                    Slider(value: $habitData.lengthInMinutes, in: 0...60, step: 1.0) {
                        Text("Length")
                    }
                    Spacer()
                    Text("\(Int(habitData.lengthInMinutes)) minutes")
                }
                ColorPicker("Color", selection: $habitData.color)
                HStack {
                    Picker("Times", selection: $habitData.momentOfDay) {
                        Text("Morning").tag(Times.morning)
                        Text("Afternoon").tag(Times.afternoon)
                        Text("Evening").tag(Times.evening)
                        Text("Night").tag(Times.night)
                        Text("All day").tag(Times.all)
                        
                    }.pickerStyle(MenuPickerStyle())
                    Spacer()
                    Image(systemName: habitData.momentOfDay.rawValue)
                }
            }
            Section(header: Text("Tasks")) {
                ForEach(habitData.tasks, id: \.self) { task in
                    Text(task)
                }
                .onDelete { indices in
                    habitData.tasks.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Task", text: $newTask)
                    Button(action: {
                        withAnimation {
                            habitData.tasks.append(newTask)
                            newTask = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newTask.isEmpty)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(habitData: .constant(Habit.data[0].emptyData))
    }
}
