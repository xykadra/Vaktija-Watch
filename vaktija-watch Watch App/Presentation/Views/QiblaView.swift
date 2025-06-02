//
//  QiblaView.swift
//  vaktija-watch
//
//  Created by Mirza Kadric on 2. 6. 2025..
//

import SwiftUI

struct QiblaView: View {
    @StateObject var viewModel = QiblaViewModel()

    var body: some View {
        VStack {
            Text("Qibla")
                .font(.headline)
                .padding()

            Image(systemName: "location.north.line.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(viewModel.rotationAngle))
                .animation(.easeInOut, value: viewModel.rotationAngle)
                .foregroundColor(.green)

            Text("Okreni sat da bude strelica ispred.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
        }
    }
}
