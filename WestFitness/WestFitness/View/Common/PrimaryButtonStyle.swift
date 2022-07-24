//
//  PrimaryButtonStyle.swift
//  WestFitness
//
//  Created by Marco Mairana on 12/07/2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    var fillColor: Color  = .darkPrimaryButton
    
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration, fillColor : fillColor)
    }
    
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color
        var body: some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10
                    ).fill(fillColor)
                )
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        Button(action: {
            
        }){
            Text("Create challenge")
        }.buttonStyle(PrimaryButtonStyle())
    }
}
