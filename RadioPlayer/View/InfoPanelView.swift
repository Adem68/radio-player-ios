//
//  InfoPanelView.swift
//  RadioPlayer
//
//  Created by Adem Özcan on 17.10.2021.
//

import SwiftUI

struct InfoPanelView: View {    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0.0) {
            Spacer()
            ZStack {
                VisualEffectView()
                NowPlayingView()
            }.frame(height: 160)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
    }
}
