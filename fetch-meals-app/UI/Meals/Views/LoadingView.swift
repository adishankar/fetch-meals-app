//
//  LoadingView.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/27/23.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var animate = false
    @State private var width: CGFloat = 0
     
        var body: some View {
            ZStack(alignment: .leading) {
                GeometryReader { proxy in
                    Rectangle()
                        .fill(.gray.opacity(0.1))
                    Rectangle()
                        .fill(.yellow.opacity(0.5).gradient)
                        .frame(width: animate ? width : 0, alignment: .leading)
                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: false), value: animate)
                        .onAppear {
                            width = proxy.size.width
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 5)
            .onAppear {
                animate.toggle()
            }
        }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
