//
//  Fetch.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//

import Foundation

class AppListViewModel_Test: ObservableObject {
    var appListView = [HerokuApp(name: "Unit 01", id: "123"), HerokuApp(name: "Unit S2", id: "id2")]
    func fetch(){
        print("Fetch attempt")
    }
    
}

class AppSettingsViewModel_Test: ObservableObject {
    
//    var appSettingsView: [Dyno] = []
    var appSettingsView = [
        Dyno(app: HerokuApp(name: "Unit 01", id: "123"), type: "DynoType1", quantity: 1, id: "DynoId1"),
        Dyno(app: HerokuApp(name: "Unit S2", id: "id2"), type: "DynoType2", quantity: 0, id: "DynoId2")
    ]
    func fetch(appName: String) {
        print("Dyno fetch \(appName)")

    }
}
