//
//  MoveQuizViewModel.swift
//  MovieQuiz
//
//  Created by mihail on 17.10.2023.
//

import Foundation
import SwiftUI
import Combine

final class MovieQuizViewModel: ObservableObject{
    //MARK: - Public properties
    var image: Image? {
        willSet {
            self.objectWillChange.send()
        }
    }
    var indexLabel: Text?
    var questionLabel: Text?
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
    
    func onYesButton() -> AnswerState {
        return givenAnswer(true) ? .correct : .incorrect
    }
    
    func onNoButton() -> AnswerState {
        return givenAnswer(false) ? .correct : .incorrect
    }
    
    //MARK: - Privates methods
    private func givenAnswer(_ yesOrOn: Bool) -> Bool{
        guard let isCorrect = currentQuestion?.correctAnswer else { return false }
        nextQuestion()
        return isCorrect == yesOrOn
    }
    
    private func nextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [ weak self] in
            guard let self = self else { return }
            
            self.questionFactory?.nextQuestion()
            self.currentIndex = currentIndex < 10 ? currentIndex + 1 : 1
            self.show()
        }
    }
    
    
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

//MARK: - Enums
enum AnswerState {
    case correct, incorrect, normal
}
