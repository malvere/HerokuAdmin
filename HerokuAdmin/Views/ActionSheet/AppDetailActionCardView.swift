//
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 26.08.2022.
//

import SwiftUI
import Combine


//  ActionSheet View
struct ActionSheet: View {
    @State var offsetY: CGFloat = UIScreen.main.bounds.height
    @Binding var isShowing: Bool
    
    let heightToDisappear = UIScreen.main.bounds.height
    let bgColor: Color = Color(UIColor.systemBackground)
    let callback: (() -> ())?
    
    
    init(
        isShowing: Binding<Bool>,
        callback: (() -> ())? = nil
    ) {
        _isShowing = isShowing
        self.callback = callback
    }
    
    func hide() {
        offsetY = heightToDisappear
        isShowing = false
        callback?()
    }
    
    var topMiddleBar: some View {
        Capsule()
            .frame(width: 130, height: 5)
            .foregroundColor(.gray)
            .padding(.top, 20)
    }
    
    var itemsView: some View {
        VStack{
            SheetAppDetailView()
                .padding()
        }
    }
    
    var interactiveGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height > 0 {
                    offsetY = value.location.y
                }
            }
            .onEnded { value in
                let diff = abs(offsetY - value.location.y)
                if diff > 100 {
                    hide()
                } else {
                    offsetY = 0
                }
            }
    }
    
    var outOfFocus: some View {
        Group {
            if isShowing {
                GreyBlurView {
                    hide()
                }
            }
        }
    }
    
    var sheetView: some View {
        VStack {
            Spacer()
            
            VStack {
                topMiddleBar
                    .onTapGesture {
                        hide()
                    }
                itemsView
            }
            .background(bgColor)
            .cornerRadius(15)
            .offset(y: offsetY)
            .gesture(interactiveGesture)
        }
    }
    
    var bodyContent: some View {
        ZStack {
            outOfFocus
            sheetView
        }
    }
    
    var body: some View {
        bodyContent
            .animation(.default, value: offsetY)
            .onReceive(Just(isShowing), perform: {
                isShowing in offsetY = isShowing ? 0 : heightToDisappear
            })
    }
}


struct ActionSheet_Preview: PreviewProvider {
    static var previews: some View {
        ActionSheet(isShowing: .constant(true))
    }
}
