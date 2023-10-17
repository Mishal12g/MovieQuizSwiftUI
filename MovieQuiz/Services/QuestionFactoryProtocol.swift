//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by mihail on 17.10.2023.
//

import Foundation

protocol QuestionFactoryProtocol {
    func didReceiveNextQuestion(question: QuizQuestion)
}
