//
//  Challenge.swift
//  WestFitness
//
//  Created by Marco Mairana on 20/07/2022.
//

import Foundation

struct Challenge: Codable {
    
    let exercise: String
    let startAmount: Int
    let increase: Int
    let lenght: Int
    let userId: String
    let startDate: Date
    
}
