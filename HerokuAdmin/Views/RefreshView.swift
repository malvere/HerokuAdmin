//
//  RefreshView.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 22.12.2021.
//

import SwiftUI

struct PieSegment: Shape {
    var start: Angle
    var end: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.addArc(center: center, radius: rect.midX, startAngle: start, endAngle: end, clockwise: false)
        return path
            .strokedPath(.init(lineWidth: 30))
    }
}

struct RefreshButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width:120, height: 120, alignment: .center)
                .blur(radius: 0)
                .padding()
                .mask(grad)
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                .resizable()
                .frame(width: 45, height: 45)
                .foregroundColor(.black)
                .padding()
        }
    }
}

let grad = RadialGradient(
    gradient: Gradient(
        stops: [
            .init(color: .purple, location: 0.0),
            .init(color: .clear, location: 0.4)
        ]),
    center: .center,
    startRadius: 40,
    endRadius: 150
)

struct RefreshView: View {
    @State var intensity: CGFloat = 0
    
    private var anima: Animation {
        Animation.easeInOut(duration: 2)
            .repeatForever(autoreverses: false)
    }
    private var revAnim: Animation {
        Animation.easeInOut(duration: 2)
            .repeatForever(autoreverses: true)
    }
    
    var body: some View {
        VStack {
            Text("Error reaching Heroku :^(")
                .fontWeight(.heavy)
            HStack {
                Text("Check your Heroku token-> ")
                    .font(.caption)
                    .fontWeight(.bold)
                    .opacity(0.60)
                Image(systemName: "command.circle.fill")
                    .padding(-10)
            }
            Text("  and internet connection, then press refresh button.")
                .font(.caption)
                .fontWeight(.bold)
                .opacity(0.60)
//            Button {
//                print("fetched")
//            } label: {
//                ZStack {
//                    Circle()
//                        .frame(width:200, height: 200, alignment: .center)
//                        .blur(radius: 20)
//                        .mask(grad)
//                    Circle()
//                        .frame(width: 100, height: 100, alignment: .center)
//                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
//                        .resizable()
//                        .frame(width: 45, height: 45)
//                        .foregroundColor(.black)
//                        .padding()
//                }
//            }
//            .preferredColorScheme(.dark)
        }
        
    }
}
struct RefreshView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshView()
        //                    .previewLayout(.sizeThatFits)
    }
}

