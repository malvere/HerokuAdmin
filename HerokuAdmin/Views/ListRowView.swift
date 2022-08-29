//
//  ListRowView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//

// Model for single row in ContentView
import SwiftUI

struct ListRowView: View {
    let appName: String
    
    var body: some View {
        HStack {
            Text(appName)
                .bold()
            Spacer()
        }
        .padding()
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(appName: "this is the app").previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
