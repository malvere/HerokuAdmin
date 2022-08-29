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
    @State private var action: Int? = 0
    
//    ActionSheet variables
    @State var isShowing: Bool = false
    @State var isBlured: Bool = false
    let blured: CGFloat = 6
    var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
    
//    Rounded NavigationBar Title font
    init() {
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold) ?? titleFont.fontDescriptor,
            size: titleFont.pointSize
        )
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
    }
    
    var mainView: some View {
        VStack {
            if viewModel.appListView.isEmpty {
//                Refresh Button
                Button {
                    viewModel.fetch()
                } label: {
                    RefreshButton()
                }
                RefreshView()
                
            } else {
//                Dynos List
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
                .listStyle(.inset)
            }
        }
        .navigationTitle("My Dynos")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    print("---")
                    print(viewModel.appListView)
                    print("---")
                    self.action = 1
                } label: {
                    Image(systemName: "tray.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.orange)
                    NavigationLink(destination: SheetContentView().ignoresSafeArea(), tag: 1, selection: $action) {
                        EmptyView()
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //
                    isShowing = true
                    isBlured  = true
                } label: {
                    Image(systemName: "command.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.purple)
                }
            }}
        
        
//        If JSON fetch will fail, refresh button with instructions will appear
        .onAppear {
            viewModel.fetch()
        }
        .preferredColorScheme(.dark)
    }
    
//    Main Body
    var body: some View {
        ZStack {
            NavigationView{
                mainView
                    .animation(.default, value: blured)
                    .blur(radius: isBlured ? blured : 0, opaque: false)
            }
            .navigationBarHidden(true)
            VStack {
                ActionSheet(isShowing: $isShowing) {
                    isBlured = false
                }
            }
        }
    }
}


//  Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}


