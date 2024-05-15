//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Yo on 29/1/24.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get set }  
    var gameCount: Int  { get set }
    var bestGame: GameRecord { get set }
    var totalCorrectAnswer: Int { get set }
    var totalAmount: Int { get set }
    

    func store(correct count: Int, total amount: Int)  //  метод для сохранения текущего результата игры
}
