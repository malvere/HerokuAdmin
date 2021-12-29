//
//  AppDetailView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//

// Dyno info screen
import SwiftUI

struct AppDetailViewSetup: View {
    
    @State var appState: Bool = true
    
    let appName: String
    let dyno: Dyno
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack(alignment: .center) {
                Toggle(isOn: $appState, label: {
                    if appState {
                        Image(systemName: "bolt.circle.fill")
                            .foregroundColor(.green)
                        Text("Status:")
                            .font(.title3)
                            .bold()
                        Text("on")
                            .font(.system(.body, design: .monospaced))
                            .scaledToFit()
                    } else {
                        Image(systemName: "bolt.slash.circle")
                            .foregroundColor(.red)
                        Text("Status:")
                            .font(.title3)
                            .bold()
                        Text("off")
                            .font(.system(.body, design: .monospaced))
                            .scaledToFit()
                    }
                    
                })
                    .onTapGesture {
                        Task {
                            await fetchJson(appName: appName, dyno: dyno, scale: dyno.quantity == 1 ? 0 : 1)
                        }
                    }
            }
            .padding(.horizontal, 30)
            Divider()
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center) {
                    Text("Type: ")
                        .font(.title3)
                        .bold()
                    Text(dyno.type)
                        .font(.system(.body, design: .monospaced))
                        .scaledToFit()
                }
                HStack(alignment: .center) {
                    Text("ID: ")
                        .font(.title3)
                        .bold()
                    Text(dyno.id)
                        .font(.system(.body, design: .monospaced))
                        .minimumScaleFactor(0.5)
                        .scaledToFit()
                }
            }
            .padding(.horizontal, 30)
        }
        .onAppear {
            appState = dyno.quantity == 1 ? true : false
        }
        .frame(minHeight: 180)
        .background(Color.purple.opacity(0.2))
        .cornerRadius(40)
        .padding()
    }
}

struct AppDetailViewS: View {
    
    let appName: String
    
    @StateObject var settingsModel = AppSettingsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(settingsModel.appSettingsView, id:\.self) {
                    dyno in AppDetailViewSetup(appName: appName, dyno: dyno)
                }
            }
        }
        .onAppear {
            settingsModel.fetch(appName: appName)
        }
        .navigationTitle(appName)
    }
}


struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dynos = Dyno(app: HerokuApp(name: "ha", id: "1"), type: "Baka", quantity: 0, id: "dyno id")
        AppDetailViewSetup(appName: "kek1", dyno: dynos)
            .navigationTitle("Title")
    }
}
