//
//  ContentView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 06.12.2021.
//

// Main app screen
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @StateObject var viewModel = AppListViewModel()
    @State private var showSettings: Bool = false
    @StateObject var keyc = Keychain()
    
    var body: some View {
        VStack {
            if viewModel.appListView.isEmpty {
                
                // Refresh Button
                Button {
                    viewModel.fetch()
                } label: {
                    RefreshButton()
                }
                RefreshView()
                
            } else {
                
                // Dynos List
                List {
                    ForEach(viewModel.appListView, id: \.self) { app in
                        HStack {
                            ListRowView(appName: app.name)
                            NavigationLink(destination: AppDetailViewS(appName: app.name), label: {
                                Text("")
                            })
                        }
                    }
                }
            }
        }
        .navigationTitle("My Dynos")
        .toolbar {
            Button(action: {
                authorize()
            }) {
                
                Image(systemName: "command.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.purple)
            }
            .sheet(isPresented: $showSettings) {
            } content: {
                TokenView()
            }
        }
        
        // If JSON fetch will fail, refresh button with instructions will appear
        .onAppear {
            viewModel.fetch()
        }
        .preferredColorScheme(.dark)
    }
    
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
                    print("Success!")
                    withAnimation(.easeOut){
                        showSettings = true
                    }
                }
            })
        } else {
            print("Biometrics can't be used")
        }
    }
}


// Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}


