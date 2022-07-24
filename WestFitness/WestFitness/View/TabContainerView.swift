//
//  TabContainerView.swift
//  WestFitness
//
//  Created by Marco Mairana on 21/07/2022.
//

import SwiftUI

struct TabContainerView: View {
    
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedTab) {
            ForEach(tabContainerViewModel.tabItemsViewModel, id: \.self) { viewModel in
                tabView(for: viewModel.type).tabItem {
                    Image(systemName: viewModel.imageName)
                    Text(viewModel.title)
                }.tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .log:
            Text("Log")
        case .challengeList:
            Text("ChallengeList")
        case .settings:
            Text("Settings")
        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}
