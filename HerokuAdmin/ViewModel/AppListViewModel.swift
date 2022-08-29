//
//  Fetch.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//

import Foundation

class AppListViewModel: ObservableObject {
    @Published var appListView: [HerokuApp] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.heroku.com/apps") else {
            return
        }
        
        // Define API Headers
        let token = String(decoding: Keychain.load(key: Constants.keychainKey) ?? Data("".utf8), as: UTF8.self).lowercased()
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Accept": "application/vnd.heroku+json; version=3",
            "Authorization": "Bearer \(token)"
        ]
        
        // Create URLSession Task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let data = data else {
                return
            }
            
            // Covert to JSON
            do {
                let appList = try JSONDecoder().decode([HerokuApp].self, from: data)
                DispatchQueue.main.async {
                    self?.appListView = appList
                    
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
