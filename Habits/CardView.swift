//
//  ContentView.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI

struct CardView: View {
    let habit: Habit
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("\(habit.title)")
                    .font(.headline)
                Spacer()
                Image(systemName: habit.momentOfDay.rawValue)
                    .renderingMode(.original)
                    .padding(.trailing, 10)
            }
            Spacer()
            HStack{
                Label("\(habit.history.count) played", systemImage: "gamecontroller")
                    .font(.footnote)
                Spacer()
                Label("\(habit.lengthInMinutes) min", systemImage: "stopwatch")
                    .padding(.trailing, 10)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(habit.color.accessibleFontColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(habit: Habit.data[0])
            .background(Habit.data[3].color)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
