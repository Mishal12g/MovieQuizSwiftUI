//
//  Image+Extensions.swift
//  MovieQuiz
//
//  Created by mihail on 15.10.2023.
//

import Foundation
import SwiftUI

//extension View {
//    func customImageStyle(_ img: Image, _ isActivBorder: Bool) -> Image {
//
//
//    }
//}

struct ImageView {
    let image: Image
    let color: Color?
    
    init(image: Image, color: Color? = nil) {
        self.image = image
        self.color = color
    }
    
    var bady: some View {
        image
            .resizable()
            .cornerRadius(15)
            .padding(.vertical, 20)
    }
    
    var badyTwo: some View {
        image
            .resizable()
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(color!, lineWidth: 8))
            .padding(.vertical, 20)
    }
}
