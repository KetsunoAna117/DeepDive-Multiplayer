//
//  OxygenBar.swift
//  DeepDive
//
//  Created by Hans Arthur Cupiterson on 27/04/24.
//

import SwiftUI

struct OxygenBar: View {
    @EnvironmentObject var connectionManager: MPConnectionManager
    @EnvironmentObject var matchManager: MatchManager
    
    @State var current: CGFloat = 100
    @State var max: CGFloat = 100
    
    @State private var progressColor: Color = Color.green
    @State private var percentage: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 30, height: 200)
            Rectangle()
                .fill(progressColor)
                .frame(width: 30, height: percentage)
        }
        .onChange(of: matchManager.controlledPlayerOxygen) { oldValue, newValue in
            current = newValue
            percentage = calculatePercentage() * 200
            progressColor = changeColor()
        }
        .onAppear(){
            percentage = calculatePercentage() * 200
            progressColor = changeColor()
        }
    }
    
    func calculatePercentage() -> CGFloat{
        return current / max
    }
    
    func changeColor() -> Color{
        let percentage = calculatePercentage()
        
        if percentage > 0.75 {
            return Color.green
        }
        else if percentage <= 0.75 && percentage > 0.50 {
            return Color.yellow
        }
        else if percentage <= 0.50 && percentage > 0.25 {
            return Color.orange
        }
        else if percentage <= 0.25 && percentage > 0 {
            return Color.red
        }
        return Color.gray
    }
}

#Preview {
    OxygenBar()
}
