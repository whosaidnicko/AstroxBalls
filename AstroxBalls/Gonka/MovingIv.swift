//
//  MovingIv.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 19/01/2025.
//

import SwiftUI

struct MovingIv: View {
    @State var x: CGFloat
    @State var timer: Timer?
    @State var y: CGFloat = UIScreen.main.bounds.height
    @State var scale: Bool = false
    @State var seconds: Double
    var body: some View {
        Image("failedRed")
            .position(CGPoint(x: x, y: y))
            .scaleEffect(scale ? 0 : 1)
            .onAppear() {
                timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { _ in
                    withAnimation(Animation.linear(duration: seconds)) {
                        y -= 20
                        
                        if y < 30 {
                                scale = true
                        }
                    }
                }
            }
    }
}
