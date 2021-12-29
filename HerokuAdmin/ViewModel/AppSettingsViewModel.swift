//
//  AppSettingsViewModel.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//


import Foundation

class AppSettingsViewModel: ObservableObject {
    @Published var appSettingsView: [Dyno] = []
    
    func fetch(appName: String) {
        
        guard let url = URL(string: "https://api.heroku.com/apps/\(appName)/formation") else {
            return
        }
        let token = String(decoding: Keychain.load(key: Constants.keychainKey) ?? Data("".utf8), as: UTF8.self).lowercased()
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Accept": "application/vnd.heroku+json; version=3",
            "Authorization": "Bearer \(token)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let data = data else {
                return
            }
            
            do {
                let appSettings = try JSONDecoder().decode([Dyno].self, from: data)
                DispatchQueue.main.async {
                    self?.appSettingsView = appSettings
                    print(appSettings)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
