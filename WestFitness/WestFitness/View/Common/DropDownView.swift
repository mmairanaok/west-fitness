//
//  DropDownView.swift
//  WestFitness
//
//  Created by Marco Mairana on 13/07/2022.
//

import SwiftUI

struct DropDownView<T: DropdownItemProtocol>: View {
    @Binding var viewModel: T
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.leading)
            Button(action: {
                viewModel.isSelected.toggle()
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .semibold))
                }
            }.confirmationDialog("Select One", isPresented: Binding<Bool>(get:{
                viewModel.isSelected
            }, set: { _ in
                
            }), titleVisibility: .visible) {
                ForEach(Array(viewModel.options.enumerated()), id: \.element) { index , option in
                    Button(option.formatted) {
                        viewModel.selectedOption = option
                        viewModel.isSelected = false
                        print(option)
                    }
                }
                Button("Cancel", role: .cancel) {
                    viewModel.isSelected = false
                }
            }
            .padding(.horizontal)
                .buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
            
        }.padding(15)
    }
}

//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropDownView()
//        }.environment(\.colorScheme, .light)
//        NavigationView {
//            DropDownView()
//        }.environment(\.colorScheme, .dark)
//    }
//}
