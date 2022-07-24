//
//  UserService.swift
//  WestFitness
//
//  Created by Marco Mairana on 18/07/2022.
//

import Foundation
import Combine
import FirebaseAuth

protocol UserServiceProtocol {
    
    func currentUser() -> AnyPublisher<User?,Never>
    func signInAnonymously() -> AnyPublisher<User,CustomError>
    func observeAuthChanges() -> AnyPublisher<User?, Never>
}

final class UserService: UserServiceProtocol {
    
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, CustomError> {
        return Future<User,CustomError> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    return (promise(.failure(.auth(description: error.localizedDescription))))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    
}
