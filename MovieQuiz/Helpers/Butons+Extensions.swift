//
//  Butons.swift
//  MovieQuiz
//
//  Created by mihail on 14.10.2023.
//

import SwiftUI

extension View {
    func customButtonStyle(action: @escaping () -> Void, label: String) -> some View {
        Button(action: action) {
            Text(label)
                .foregroundStyle(Color.ypBlack)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.system(size: 20))
                .fontWeight(.medium)
        }
        .tint(.ypWhite)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}
