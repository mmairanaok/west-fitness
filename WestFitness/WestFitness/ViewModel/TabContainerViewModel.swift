//
//  TabContainerViewModel.swift
//  WestFitness
//
//  Created by Marco Mairana on 21/07/2022.
//

import Combine

final class TabContainerViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .challengeList
    
    let tabItemsViewModel = [
        TabItemViewModel(imageName: "book", title: "Log", type: .log),
        TabItemViewModel(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        TabItemViewModel(imageName: "gear", title: "Settings", type: .settings)
    ]
    
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
    
}
