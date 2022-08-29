//
//  GreyBlurView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 23.08.2022.
//

import SwiftUI


//  GrayOut overlay View
public struct GreyBlurView: View {
    let callback: (() -> ())?
    let opacity: CGFloat
    
    public init (
        callback: (() -> ())? = nil,
        opacity: CGFloat = 0.2
    ) {
        self.callback = callback
        self.opacity = opacity
    }
    
    public var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color(UIColor.systemBackground))
            .opacity(opacity)
            .blur(radius: 40, opaque: true)
            .onTapGesture {
                callback?()
            }
            .ignoresSafeArea()
    }
}


struct GreyBlurView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("TEXT")
            GreyBlurView()
                .preferredColorScheme(.dark)
        }
    }
}
