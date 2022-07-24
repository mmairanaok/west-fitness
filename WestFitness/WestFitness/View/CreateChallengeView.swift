//
//  CreateChallengeView.swift
//  WestFitness
//
//  Created by Marco Mairana on 12/07/2022.
//

import SwiftUI

struct CreateChallengeView: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    
    var dropDownList: some View {
        //        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
        //            DropDownView(viewModel: $viewModel.dropdowns[index])
        //        }
        Group {
            DropDownView(viewModel: $viewModel.exerciseDropdown)
            DropDownView(viewModel: $viewModel.startAmountDropdown)
            DropDownView(viewModel: $viewModel.increaseDropdown)
            DropDownView(viewModel: $viewModel.lenghtDropdown)
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                dropDownList
                Spacer()
                Button(action: {
                    viewModel.createChallenge()
                }){
                    Text("Create")
                        .font(.system(size: 24,weight: .medium))
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(
                title: Text("Error!"),
                message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: .default(Text("Ok"), action: {
                    viewModel.error = nil
                })
            )
        }
        .navigationTitle("Create")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
    }
}

struct CreateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChallengeView()
    }
}
