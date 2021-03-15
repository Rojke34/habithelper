//
//  RingView.swift
//  Scrumdinger
//
//  Created by Kevin on 7/02/21.
//

import SwiftUI

struct RingView: View {
    var color1 = Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    var width: CGFloat = 300
    var height: CGFloat = 300
    
    var secondsElapsed: Int
    let lengthInMinutes: Int
    
    private var lengthInSeconds: CGFloat { CGFloat(lengthInMinutes) * 60.0 }
    
    private var progress: CGFloat {
        return CGFloat(secondsElapsed) / lengthInSeconds
    }
    
    var body: some View {
        let multiplier = width / 44
        
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: width)
            Circle()
                .trim(from: 1 - progress, to: 100)
                .stroke(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(width: width, height: width)
                .shadow(color: color2.opacity(0.1), radius: 3.0 * multiplier, x: 0.0, y: 3.0 * multiplier)
                .animation(.linear)
            
            VStack {
                HStack {
                    Text("\(Int(progress * 100))")
                        .fontWeight(.bold)
                        .animation(.linear)
                    Text("%")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14 * multiplier))
                Text("Time completed").font(.footnote)
            }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(secondsElapsed: 60, lengthInMinutes: 20)
    }
}
