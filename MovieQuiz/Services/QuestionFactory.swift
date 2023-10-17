//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by mihail on 14.10.2023.
//

import Foundation

final class QuestionFactory {
    private let delegate: QuestionFactoryProtocol?
    
    let movies: [QuizQuestion] = [QuizQuestion(image: "Deadpool",
                                               text: "2",
                                               correctAnswer: true),
                                  QuizQuestion(image: "Kill Bill",
                                               text: "7",
                                               correctAnswer: true),
                                  QuizQuestion(image: "Old",
                                               text: "4",
                                               correctAnswer: true),
                                  QuizQuestion(image: "Tesla",
                                               text: "5",
                                               correctAnswer: true),
                                  QuizQuestion(image: "The Avengers",
                                               text: "8",
                                               correctAnswer: true),
                                  QuizQuestion(image: "The Dark Knight",
                                               text: "7",
                                               correctAnswer: true),
                                  QuizQuestion(image: "The Godfather",
                                               text: "5",
                                               correctAnswer: true),
                                  QuizQuestion(image: "The Green Knight",
                                               text: "2",
                                               correctAnswer: true),
                                  QuizQuestion(image: "The Ice Age Adventures of Buck Wild",
                                               text: "10",
                                               correctAnswer: true),
                                  QuizQuestion(image: "Vivarium",
                                               text: "8",
                                               correctAnswer: true)]
    
    init(delegate: QuestionFactoryProtocol){
        self.delegate = delegate
    }
    
    func nextQuestion() {
        guard let index = (1..<movies.count).randomElement(),
        let num = Float(movies[index].text) else { return }
        
        let isMore = num < 5
        let text = "Рейтинг этого фильма меньше чем 5?"
        let image = movies[index].image
        let question = QuizQuestion(image: image, text: text, correctAnswer: isMore)

        delegate?.didReceiveNextQuestion(question: question)
    }
}
