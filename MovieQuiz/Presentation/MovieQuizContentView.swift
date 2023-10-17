//
//  ContentView.swift
//  MovieQuiz
//
//  Created by mihail on 14.10.2023.
//

import SwiftUI

struct MovieQuizContentView: View {
    @ObservedObject var viewModel = MovieQuizViewModel()
    @State var isCorrect: AnswerState = .normal
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Вопрос:")
                    .foregroundStyle(Color.ypWhite)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
                
                Spacer().frame(maxWidth: .infinity)
                
                viewModel.indexLabel
                    .foregroundStyle(Color.ypWhite)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
            }
            
            switch isCorrect {
            case .correct:
                ImageView(image: viewModel.image!, color: Color.ypGreen).badyTwo .previewLayout(.sizeThatFits)
            case .incorrect:
                ImageView(image: viewModel.image!, color: Color.ypRed).badyTwo .previewLayout(.sizeThatFits)
            case .normal:
                ImageView(image: viewModel.image!).bady
                    .previewLayout(.sizeThatFits)
            }
            
            viewModel.questionLabel?
                .foregroundStyle(Color.ypWhite)
                .fontWeight(.bold)
                .font(.system(size: 23))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 42)
                .padding(.vertical, 13)
            
            HStack {
                customButtonStyle(action: {
                    isCorrect = viewModel.onNoButton()
                    hideBoarder()
                }, label: "Нет")
                
                customButtonStyle(action: {
                    isCorrect = viewModel.onYesButton()
                    hideBoarder()
                }, label: "Да")
            }
            .frame(maxHeight: 60)
            .padding(.vertical, 20)
            
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypBlack)
    }
    
    func hideBoarder() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isCorrect = .normal
        }
    }
}

#Preview {
    MovieQuizContentView()
}
