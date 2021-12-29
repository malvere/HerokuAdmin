//
//  TokenView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 12.12.2021.
//

// Token settings screen, uses LAContext for additional security
import SwiftUI

struct TokenView: View {
    
    @State private var token: String = "kekw"
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.red)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Token")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Please, input your Heroku Token below:")
                        .opacity(0.70)
                }
                Spacer()
            }
            .padding()
            
            HStack {
                Image(systemName: "key")
                    .font(.title3)
                TextField("Enter heroku token", text: $token)
                    .font(.system(.body, design: .monospaced))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.none)
            }
            .padding()
            .background(.purple.opacity(0.2))
            .cornerRadius(12)
            .padding()
            
            // Remove from keychain if token input field is empty, otherwise write new token to Keychain
            Button(action: {
                if token.isEmpty {
                    Keychain.remove(key: Constants.keychainKey)
                    print("remove error")
                } else {
                    let result = Keychain.create(key: Constants.keychainKey, data: Data(token.utf8))
                    print(result == noErr ? "Item stored!" : "Something went wrong")
                }
            }) {
                Text("Submit")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width-150)
                    .background(.green)
                    .clipShape(Capsule())
            }
            .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .preferredColorScheme(.dark)
        .onAppear {
            DispatchQueue.main.async {
                let data = Keychain.load(key: Constants.keychainKey)
                token = String(decoding: data ?? Data("".utf8), as: UTF8.self)
            }
        }
    }
}
struct TokenView_Previews: PreviewProvider {
    static var previews: some View {
        TokenView()
    }
}
