//
//  BackBTNView.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 08/12/2024.
//

import SwiftUI


struct BackBTNView: View {
    @EnvironmentObject private var rootManager: RootManager
    let action: () -> Void
    var body: some View {
        HStack {
            Button {
                vibrate()
                rootManager.thisViewPresented = .menu
                action()
            } label: {
                Image("backBTN")
            }
            Spacer()
        }
    }
}
