//
//  SheetAppDetailView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 23.08.2022.
//

import SwiftUI
import LocalAuthentication


//  SheetView Item View
private struct CardItem: View {
    @State private var sfForegroundColor: Color? = nil
    
    let label: String
    let sfSymbolName: String
    let sfSymbolColor: Color?
    let inactiveColor: Color = .gray
    let callback: (() -> ())?
    
    public init(
        label: String,
        sfSymbolName: String,
        sfSymbolColor: Color? = .primary,
        callback: (() -> ())? = nil
    ) {
        self.label = label
        self.sfSymbolName = sfSymbolName
        self.sfSymbolColor = sfSymbolColor
        self.callback = callback
    }
    
    var itemView: some View {
        HStack {
            Image(systemName: sfSymbolName)
                .font(.title)
                .foregroundColor(sfForegroundColor)
                .aspectRatio(contentMode: .fit)
                .frame(width: 19, height: 19)
                .padding(10)
            Text(label)
                .font(.headline)
                .bold()
            Spacer()
        }
        .onAppear {
            sfForegroundColor = sfSymbolColor
        }
    }
    
    var body: some View {
        if let callback = callback {
            Button {
                callback()
            } label: {
                itemView
                    .foregroundColor(.primary)
            }
        } else {
            itemView
                .foregroundColor(inactiveColor)
                .onAppear {
                    self.sfForegroundColor = inactiveColor
                }
        }
    }
}


//  Kernel Panic Button
private struct KernelPanic: View {
    
    let callback: (() -> ())?
    
    init(callback: (() -> ())? = nil)  {
        self.callback = callback
    }
    
    var state: some View {
        HStack(alignment: .center) {
            Spacer()
            Text("Kernel Panic")
                .font(.headline)
                .bold()
                .frame(height: 24)
                .padding(10)
            Spacer()
        }
    }
    
    var body: some View {
        if let callback = callback {
            Button {
                callback()
            } label: {
                state
                    .background(.red.opacity(0.2))
                    .cornerRadius(9.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9.5)
                            .strokeBorder(lineWidth: 4)
                            .opacity(1)
                    )
                    .foregroundColor(.red)
            }
        } else {
            state
                .background(.gray.opacity(0.2))
                .cornerRadius(9.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 9.5)
                        .strokeBorder(lineWidth: 4)
                        .opacity(1)
                )
                .foregroundColor(.gray)
        }
    }
}


//  Final View for ActionSheet Items
struct SheetAppDetailView: View {
    @State private var toggleState = false
    @State private var showSettings: Bool = false
    @State private var sfSymbolNameSwitch = "xmark.circle"
    
    func authorize() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authorize to continue"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        print("Biometrics Failed")
                        return
                    }
                    print("Success Auth!")
                    withAnimation(.easeOut){
                        showSettings = true
                    }
                }
            })
        } else {
            print("Biometrics can't be used")
        }
    }
    
    var body: some  View {
        VStack{
            CardItem(label: "Key", sfSymbolName: "lock.circle.fill", sfSymbolColor: .green) {
                authorize()
            }
            .sheet(isPresented: $showSettings) {
            } content: {
                TokenView()
            }
            CardItem(label: "Accent Colors", sfSymbolName: "circle.hexagongrid.circle.fill", sfSymbolColor: .purple)
            HStack {
                CardItem(label: "Panic Switch", sfSymbolName: sfSymbolNameSwitch, sfSymbolColor: .red) {
                    //
                }
                
                Toggle(isOn: $toggleState) {}
                .padding(.horizontal)
            }
            Divider()
            if toggleState == true {
                KernelPanic() {
                    //
                }
                .padding()
                .onAppear {
                    sfSymbolNameSwitch = "power.circle"
                }
            } else {
                KernelPanic()
                    .padding()
                    .onAppear {
                        sfSymbolNameSwitch = "xmark.circle"
                    }
            }
        }
        
    }
    
}


struct SheetAppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        SheetAppDetailView()
//            .preferredColorScheme(.dark)
    }
}
