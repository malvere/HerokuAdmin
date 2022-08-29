//
//  SheetContentView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 28.08.2022.
//

import SwiftUI


//  This is a Test View, it has no practical use
struct SheetContentView: View {
    @State var isShowing: Bool = false
    @State var isBlured: Bool = false
    
    @State var opacity: CGFloat = 1
    @State var opacity2: CGFloat = 0
    
    let blured: CGFloat = 6
    
    var buttonView: some View {
        Button {
            isShowing = true
            isBlured  = true
        } label: {
            ZStack{
                Group {
                    Rectangle()
                        .frame(width: 120, height: 60, alignment: .center)
                        .cornerRadius(15)
                    Text("Press Me")
                        .foregroundColor(.primary)
                        .font(.title3.bold())
                }
                .opacity(opacity)
                Group{
                    Text("потрачено")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                        .scaleEffect(2)
                }
                .opacity(opacity2)
            }
        }
    }
    
    var body: some View {
        ZStack {
            buttonView
                .animation(.default, value: blured)
                .blur(radius: isBlured ? blured : 0, opaque: false)
                .animation(.easeIn(duration: 6), value: opacity2)
            ActionSheet(isShowing: $isShowing) {
                isBlured = false
                opacity = 0
                opacity2 = 1
            }
        }
    }
}


struct SheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        SheetContentView()
            .preferredColorScheme(.dark)
    }
}
