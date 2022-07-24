//
//  RemindView.swift
//  WestFitness
//
//  Created by Marco Mairana on 13/07/2022.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
               // Spacer().frame(height: proxy.size.height * 0.3)
              //  DropDownView()
                Spacer()
                Button(action:{
                    
                }){
                    Text("Create")
                        .font(.system(size: 24,weight: .medium))
                        .foregroundColor(.primary)
                }.padding(10)
                
                
                Button(action:{
                    
                }){
                    Text("Skip reminder for now")
                        .font(.system(size: 24,weight: .medium))
                        .foregroundColor(.primary)
                }
            }.navigationTitle("Remind")
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 15)
        }
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        RemindView()
    }
}
