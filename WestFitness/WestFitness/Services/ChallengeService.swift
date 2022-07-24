//
//  ChallengeService.swift
//  WestFitness
//
//  Created by Marco Mairana on 20/07/2022.
//

import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    
    func createChallenge(_ challenge: Challenge) -> AnyPublisher<Void, CustomError>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    func createChallenge(_ challenge: Challenge) -> AnyPublisher<Void, CustomError> {
        return Future<Void,CustomError> { [weak self ]promise in
            guard let mySelf = self else { return }
            do {
                _ = try mySelf.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.defaultError(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(.defaultError()))
            }
        }.eraseToAnyPublisher()
    }
    
    
}
