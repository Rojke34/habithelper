//
//  HabitView.swift
//  Habits
//
//  Created by Kevin on 6/02/21.
//

import SwiftUI
import AVFoundation

struct HabitView: View {
    @Binding var habit: Habit
    
    @StateObject var customTimer = CustomTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]), center: .center, startRadius: 5, endRadius: 500))
                .blur(radius: 1.0)
            VStack{
                Text(habit.title)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(30)
                Spacer()
                RingView(secondsElapsed: customTimer.secondsElapsed, lengthInMinutes: habit.lengthInMinutes)
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(habit.tasks, id: \.self) { task in
                            Text(task)
                                .foregroundColor(.accentColor)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        }
                    }
                })
                .padding()            
            }
        }
        .padding()
        .foregroundColor(habit.color.accessibleFontColor)
        .onAppear() {
            customTimer.reset(lengthInMinutes: habit.lengthInMinutes)
            customTimer.startTimer()
        }
        .onDisappear() {
            let newHistory = History(tasks: habit.tasks, lengthInMinutes: habit.lengthInMinutes)
            habit.history.append(newHistory)
            customTimer.stopTimer()
        }
        .navigationTitle("You Rock!")
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: .constant(Habit.data[0]))
    }
}
