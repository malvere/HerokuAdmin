//
//  AppDetailView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//

//  Dyno info screen
import SwiftUI


//  View which resembles Dyno Status
private struct DynoStatusInfoView: View {
    let sfColor: Color
    let sfSymbol: String
    let statusString: String
    
    var body: some View {
        HStack{
            ZStack{
                Image(systemName: "square")
                    .foregroundColor(sfColor)
                    .font(.largeTitle)
                Image(systemName: sfSymbol)
                    .foregroundColor(sfColor)
                    .font(.title3)
            }
            .frame(width: 19, height: 19, alignment: .center)
            .padding(.trailing, 10)
            .padding(.vertical, 10)
            Text("Status:")
                .font(.headline)
                .bold()
            
            Text(statusString)
                .font(.system(.body, design: .monospaced))
                .scaledToFit()
        }
    }
}


//  Type and ID for Dyno info
private struct DynoInfoItemView: View {
    let title1: String
    let title2: String
    let sfSymbol: String
    let sfBackgroudColor: Color
    
    var body: some View {
        HStack {
            ZStack{
                Image(systemName: "square.fill")
                    .font(.largeTitle)
                    .foregroundColor(sfBackgroudColor)
                Image(systemName: sfSymbol)
                    .font(.title2)
                    .frame(width: 0, height: 19)
                    .padding(10)
            }
            .frame(width: 19, height: 19, alignment: .center)
            .padding(.trailing, 10)
            .padding(.vertical, 10)
            Text(title1)
                .font(.headline)
                .bold()
            Spacer()
            Text(title2)
                .font(.system(.body, design: .monospaced))
                .scaledToFit()
        }
    }
}


//  View for the ability to dynamically change icon and color depending on dyno quantity
private struct DynoStatusCell: View {
    let isOn: Bool
    
    var body: some View {
        switch isOn {
        case true:
            DynoStatusInfoView(sfColor: .green, sfSymbol: "bolt.circle.fill", statusString: "on")
        case false:
            DynoStatusInfoView(sfColor: .red, sfSymbol: "bolt.slash.circle", statusString: "off")
        }
    }
}

//  DynoStatus View with Toggle switch
private struct DynoStatusView: View {
    @State var toggleState: Bool = false
    let appName: String
    let dyno: Dyno
    
    var body: some View {
        
        HStack{
            DynoStatusCell(isOn: toggleState)
            Spacer()
            Toggle(isOn: $toggleState) {}
                .onTapGesture {
                    Task {
                        await fetchJson(appName: appName, dyno: dyno, scale: dyno.quantity == 1 ? 0 : 1)
                    }
                }
        }
        .onAppear {
            toggleState = dyno.quantity == 1 ? true : false
        }
    }
}


//  ViewSetup
private struct AppDetailViewSetup: View {
    let appName: String
    let dyno: Dyno
    
    var statusView: some View {
        DynoStatusView(appName: appName, dyno: dyno)
    }
    
    var typeView: some View {
        DynoInfoItemView(title1: "Type:", title2: dyno.type, sfSymbol: "square.on.square.squareshape.controlhandles", sfBackgroudColor: .indigo)
    }
    
    var idView: some View {
        DynoInfoItemView(title1: "ID:", title2: dyno.id, sfSymbol: "barcode.viewfinder", sfBackgroudColor: .blue)
            .contextMenu {
                Button {
                    UIPasteboard.general.string = dyno.id
                } label: {
                    Image(systemName: "arrow.right.doc.on.clipboard")
                    Text("Copy to Clipboard")
                }
                
            }
        
    }
    
    var body: some View {
        Section(content: {
            List {
                statusView
                typeView
                idView
            }
        }, header: {
            Text(dyno.type)
        })
    }
}

//  View Representation and JSON fetch
struct AppDetailViewS: View {
    @StateObject var settingsModel = AppSettingsViewModel()
    let appName: String
    
    var body: some View {
        Form {
            ForEach(settingsModel.appSettingsView, id:\.self) {
                dyno in AppDetailViewSetup(appName: appName, dyno: dyno)
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
        AppDetailViewS(appName: "Unit 01")
            .preferredColorScheme(.dark)
    }
}
