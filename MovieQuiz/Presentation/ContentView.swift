//
//  ContentView.swift
//  MovieQuiz
//
//  Created by mihail on 14.10.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel = MovieQuizViewModel()
    
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
            viewModel.image?
                .resizable()
                .cornerRadius(15)
                .padding(.vertical, 20)
            
            viewModel.questionLabel?
                .foregroundStyle(Color.ypWhite)
                .fontWeight(.bold)
                .font(.system(size: 23))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 42)
                .padding(.vertical, 13)
            
            HStack {
                Button {
                    viewModel.nextQuestion()
                } label: {
                    Text("Нет")
                        .foregroundStyle(Color.ypBlack)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                }
                .tint(.ypWhite)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                
                Button {
                    
                } label: {
                    Text("Да")
                        .foregroundStyle(Color.ypBlack)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                }
                .tint(.ypWhite)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
            }
            .frame(maxHeight: 60)
            .padding(.vertical, 20)
            
            
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypBlack)
    }
}

#Preview {
    ContentView()
}

protocol QuestionFactoryProtocol {
    func didReceiveNextQuestion(question: QuizQuestion)
}

final class MovieQuizViewModel: ObservableObject{
    var image: Image?
    var indexLabel: Text?
    var questionLabel: Text?
    
    //MARK: - Public properties
    var objectWillChange = ObservableObjectPublisher()
    
    //MARK: - Privates properties
    private var questionFactory: QuestionFactory?
    private var currentIndex = 1
    private var currentQuestion: QuizQuestion? {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    //MARK: - Init
    init() {
        questionFactory = QuestionFactory(delegate: self)
        questionFactory?.nextQuestion()
        show()
    }
    
    //MARK: - Public methods
    func nextQuestion() {
        questionFactory?.nextQuestion()
        currentIndex = currentIndex < 10 ? currentIndex + 1 : 1
        show()
    }
    
    //MARK: - Privates methods
    private func convert(question: QuizQuestion?) -> QuizStepViewModel? {
        guard let question = question else { return nil}
        let viewModel = QuizStepViewModel(image: Image(question.image), question: question.text, questionNumber: "\(currentIndex)/10")
        
        return viewModel
    }
    
    private func show() {
        guard let model = convert(question: currentQuestion) else { return }
        
        image = model.image
        indexLabel = Text(model.questionNumber)
        questionLabel = Text(model.question)
    }
}

//MARK: - Delegate
extension MovieQuizViewModel: QuestionFactoryProtocol {
    
    func didReceiveNextQuestion(question: QuizQuestion) {
        currentQuestion = question
    }
}