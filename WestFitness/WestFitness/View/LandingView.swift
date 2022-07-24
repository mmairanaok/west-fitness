//
//  ContentView.swift
//  WestFitness
//
//  Created by Marco Mairana on 12/07/2022.
//

import SwiftUI

struct LandingView: View {
    
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.10)
                    Text("Increment")
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    NavigationLink(destination: CreateChallengeView(), isActive: $isActive ) {
                        Button(action:{
                            // action
                            isActive.toggle()
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName:"plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("Create a challenge")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24 , weight: .semibold))
                                Spacer()
                            }
                        }.padding(.all, 15)
                            .buttonStyle(PrimaryButtonStyle())
                    }
                    //Fin Vstack
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                ).background(
                    Image("launchBackground")
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.4))
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
