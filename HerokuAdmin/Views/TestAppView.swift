////
////  AppDetailView.swift
////  HerokuAdmin
////
////  Created by Kostya Kuznetsov on 07.12.2021.
////
//
//import SwiftUI
//
//struct Test: View {
//    //    @StateObject var settingsModel = AppSettings(type: "run", quantity: 1)
//    @State var appState: Bool = false
//    //    @State var appsst = AppSettingsViewModel().self
//    @State var stateText: String = ""
//    let appName: String
//    let appId: String
//    let app: AppSettings
//    
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            
//            HStack(alignment: .center) {
//                Toggle(isOn: $appState, label: {
//                    if appState {
//                        Image(systemName: "bolt.circle.fill")
//                            .foregroundColor(.green)
//                        Text("Status:")
//                            .font(.title3)
//                            .bold()
//                        Text("on")
//                            .font(.system(.body, design: .monospaced))
//                            .scaledToFit()
//                    } else {
//                        Image(systemName: "bolt.slash.circle")
//                            .foregroundColor(.red)
//                        Text("Status:")
//                            .font(.title3)
//                            .bold()
//                        Text("off")
//                            .font(.system(.body, design: .monospaced))
//                            .scaledToFit()
//                    }
//                    
//                })
//            }
//            .padding(.horizontal, 30)
//            Divider()
//            VStack(alignment: .leading, spacing: 20) {
//                HStack(alignment: .center) {
//                    Text("Type: ")
//                        .font(.title3)
//                        .bold()
//                    Text(app.type)
//                        .font(.system(.body, design: .monospaced))
//                        .scaledToFit()
//                }
//                HStack(alignment: .center) {
//                    Text("ID: ")
//                        .font(.title3)
//                        .bold()
//                    Text(appId)
//                        .font(.system(.body, design: .monospaced))
//                        .minimumScaleFactor(0.5)
//                        .scaledToFit()
//                }
//
//            }
//            .padding(.horizontal, 30)
//
//
//        }
//        .navigationTitle(appName)
//        .onAppear {
//            appState = app.quantity == 1 ? true : false
//            
//        }
//        .frame(minHeight: 180)
//        .background(Color.purple.opacity(0.2))
//        .cornerRadius(40)
//        .padding()
//    }
//    
//}
//
//
//struct TestL: View {
//    
//    init() {
//            var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
//            titleFont = UIFont(
//                descriptor:
//                    titleFont.fontDescriptor
//                    .withDesign(.rounded)?
//                    .withSymbolicTraits(.traitBold)
//                    ??
//                    titleFont.fontDescriptor,
//                size: titleFont.pointSize
//            )
//
//            UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
//        }
//    
//    @State var curapp = [AppSettings(type: "run", quantity: 1, dynoID: "!@#"), AppSettings(type: "web", quantity: 0, dynoID: "9918"), AppSettings(type: "segg", quantity: 1, dynoID: "1111")]
//    
//    @State var twoapp = [AppSettings(type: "dyno", quantity: 1, dynoID: ")))")]
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(curapp, id:\.self) {
//                    app in Test(appName: "Test", appId: "e46a71fa-facb-434c-8e0a-6e6b37e74f06", app: app)
//                    
//                }
//            }
//            .padding(.top)
//        }
//    }
//}
//
//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TestL()
//        }
//    }
//}
//
//
