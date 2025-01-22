//
//  MeteoritView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI

struct MeteoritView: View {
    
    let position: CGPoint
    @State var go: Bool = false
    var body: some View {
        Image(ConstantsFiles.Images.meteorit)
            .position(go ? position : CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: 0))
            .rotationEffect(.degrees(Double.random(in: 0...190)))
            .onAppear {
                withAnimation(Animation.linear(duration: TimeInterval.random(in: 6...10))) {
                    go = true
                }
            }
    }
}
