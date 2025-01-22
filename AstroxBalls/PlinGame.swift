//
//  PlinGame.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 21/01/2025.
//

import SwiftUI


struct PlinGame: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("menuBackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                BackBTNView() {
                    dismiss()
                    
                }
                ZStack {
                    Text("Loading...")
                        .font(.custom(Font.inter, size: 30))
                        .foregroundStyle(.white)
                    WKWebViewRepresentable(url: URL(string: "https://plays.org/game/super-plinko/")!)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
