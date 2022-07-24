//
//  DropdownItemProtocol.swift
//  WestFitness
//
//  Created by Marco Mairana on 13/07/2022.
//

import Foundation

protocol DropdownItemProtocol {
    var options: [DropdownOption] { get }
    var headerTitle: String { get }
    var dropdownTitle: String { get }
    var isSelected: Bool { get set }
    var selectedOption: DropdownOption { get set}
}

protocol DropdownOptionProtocol {
    var toDropdownOption: DropdownOption { get }
}

struct DropdownOption: Hashable {
    
    enum DropdownOptionType: Hashable {
        case text(String)
        case number(Int)
    }

    let type: DropdownOptionType
    let formatted: String

}
