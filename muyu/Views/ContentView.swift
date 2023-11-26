//
//  ContentView.swift
//  muyu
//
//  Created by Fumiaki Tou on 2023/11/26.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    let player: Player = Player()
    @State private var isAutoPlayed: Bool = false
    @State private var isButtonDisabled: Bool = false
    @State private var workingTimer: Timer? = nil
    @State private var sliderValue: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("电子木鱼")
                    .foregroundColor(.red)
                    .font(.title)
                    .bold()
                Spacer()
            }

            VStack(spacing: 30) {

                
                Button(action: {
                    player.playSound()
                }) {
                    VStack {
                        Image("muyu2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .disabled(isButtonDisabled)
                
                Toggle("自动播放", isOn: $isAutoPlayed)
                    .foregroundColor(.red)
                    .onChange(of: isAutoPlayed, {
                        if self.isAutoPlayed {
                            self.workingTimer = player.autoPlaySound(speed: sliderValue)
                            self.isButtonDisabled = true
                        } else {
                            self.workingTimer?.invalidate()
                            self.workingTimer = nil
                            self.isButtonDisabled = false
                        }
                    })
                
                HStack {
                    Text("慢")
                        .foregroundColor(.red)
                    Slider(value: self.$sliderValue, in:0.0...0.9)
                    Text("快")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .onReceive([self.sliderValue].publisher.first()) { _ in
                if self.isAutoPlayed {
                    self.workingTimer?.invalidate()
                    self.workingTimer = player.autoPlaySound(speed: sliderValue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
