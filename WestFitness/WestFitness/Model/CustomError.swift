//
//  CustomError.swift
//  WestFitness
//
//  Created by Marco Mairana on 21/07/2022.
//

import Foundation

enum CustomError: LocalizedError {
case auth(description: String)
case defaultError(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .defaultError(description):
            return description ?? "An error has ocurred in West App"
        }
    }
}
