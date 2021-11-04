//
//  NowPlayingView.swift
//  RadioPlayer
//
//  Created by Adem Özcan on 17.10.2021.
//

import SwiftUI
import Kingfisher

struct NowPlayingView: View {
    @StateObject var radioPlayer = RadioPlayer.instance
    @State var stationName = "Not Playing!"
    
    var body: some View {
        HStack() {
            Spacer()
            ZStack {
                if radioPlayer.isPlaying || radioPlayer.currentRadio?.name != nil {
                    KFImage(URL(string: radioPlayer.currentRadio!.imageUrl))
                        .resizable()
                        .foregroundColor(Color.secondary)
                        .frame(width: 100, height: 100)
                } else {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 100, height: 100)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                    Image(systemName: "music.note")
                        .foregroundColor(Color.secondary)
                        .colorInvert()
                }
            }
            Text(radioPlayer.currentRadio?.name ?? "Not Playing")
                .padding(10)
            Spacer()
            if radioPlayer.isPlaying {
                Button(action: {
                    print("stop")
                    radioPlayer.stop()
                }) {
                    Image(systemName: "stop.fill")
                        .renderingMode(.original)
                        .font(.system(size: 24, weight: .regular))
                }
            } else if radioPlayer.currentRadio?.name != nil {
                Button(action: {
                    print("play")
                    radioPlayer.play(radioPlayer.currentRadio!)
                }) {
                    Image(systemName: "play.fill")
                        .renderingMode(.original)
                        .font(.system(size: 24, weight: .regular))
                }
            }
            Spacer()
        }.padding(.bottom, 12)
    }
    
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
