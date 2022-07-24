//
//  CreateChallengeViewModel.swift
//  WestFitness
//
//  Created by Marco Mairana on 13/07/2022.
//

import SwiftUI
import Combine
import FirebaseAuth

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject {
    
    //    @Published var dropdowns: [ChallengePartViewModel] = [
    //        .init(type: .exercise),
    //        .init(type: .startAmount),
    //        .init(type: .lenght),
    //        .init(type: .increase)
    //    ]
    
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var lenghtDropdown = ChallengePartViewModel(type: .lenght)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    
    @Published var error: CustomError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func createChallenge() {
        print("createCHallenge")
        print("gettingUserId")
        isLoading = true
        currentUserId().flatMap { userID -> AnyPublisher<Void,CustomError> in
            return self.createChallenge(userId: userID)
        }.sink { completion in
            self.isLoading = false
            switch completion {
            case let .failure(error):
                self.error = error
                print(error.localizedDescription)
            case .finished:
                print("finished")
            }
        } receiveValue: { _ in
            print("success")
        }.store(in: &cancellables)
        
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, CustomError> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let lenght = lenghtDropdown.number else {
                  return Fail(error:.defaultError(description: "Parsing error")).eraseToAnyPublisher()
              }
        
        let challenge = Challenge(exercise: exercise,
                                  startAmount: startAmount,
                                  increase: increase,
                                  lenght: lenght,
                                  userId: userId,
                                  startDate: Date())
        return challengeService.createChallenge(challenge).eraseToAnyPublisher()
        
    }
    
    private func currentUserId() -> AnyPublisher<UserId,CustomError> {
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId,CustomError> in
            if let userId = user?.uid {
                return Just(userId).setFailureType(to: CustomError.self).eraseToAnyPublisher()
            } else {
                return self.userService.signInAnonymously().map{ $0.uid}.eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
}

extension CreateChallengeViewModel {
    
    struct ChallengePartViewModel: DropdownItemProtocol {
        
        var selectedOption: DropdownOption
        
        private let type: ChallengePartType
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected = false
        
        init(type: ChallengePartType) {
            
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.toDropdownOption }
            case .increase:
                self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
            case .lenght:
                self.options = LenghtOption.allCases.map { $0.toDropdownOption }
            case .startAmount:
                self.options = StartOption.allCases.map { $0.toDropdownOption }
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily increase"
            case lenght = "Challenge Lenght"
            
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized)
            }
        }
        
        enum StartOption: Int, CaseIterable,  DropdownOptionProtocol {
            case one = 1 , two , three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)")
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1 , two , three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)")
            }
        }
        
        enum LenghtOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7 , fourteen = 14 , twentyOne = 21 , twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue) days" )
            }
        }
        
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
    
}
