//
//  HearthPokazateli.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 18/01/2025.
//

import SwiftUI

struct HearthPokazateli: View {
    @EnvironmentObject private var rootManager: RootManager
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(LinearGradient(colors: [Color.init(hex: "#43466E"), Color.init(hex: "#585E81")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                HStack(spacing: 0) {
                    ForEach(1..<6, id: \.self) { number in
                        Image(rootManager.lifes < number ? "inactiveh" : "activeh")
                    }
                }
            }
            .frame(width: 134, height: 35)
    }
}
