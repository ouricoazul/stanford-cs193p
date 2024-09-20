//
//  ContentView.swift
//  stanford-cs193p
//
//  Created by Nicholas Hendryx on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🦔","🦔","🌵","🌵","🪡","🪡","🐡","🐡","🐝","🐝","📌","📌","🗡️","🗡️","🐗","🐗","🧛🏻‍♂️","🧛🏻‍♂️"]
    @State var overallTheme = Theme.prickly
    @State var cardColor = Color.red
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChangers
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: false)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
    }
    
    var themeChangers: some View {
        HStack {
            changeTheme(to:Theme.prickly)
            Spacer()
            changeTheme(to:Theme.blue)
            Spacer()
            changeTheme(to:Theme.round)
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    enum Theme {
        case prickly, blue, round
    }
    
    func changeTheme(to theme: Theme) -> some View {
        Button(action: {
            switch theme {
            case Theme.prickly:
                emojis = ["🦔","🦔","🌵","🌵","🪡","🪡","🐡","🐡","🐝","🐝","📌","📌","🗡️","🗡️","🐗","🐗","🧛🏻‍♂️","🧛🏻‍♂️"]
                cardColor = Color.red
            case Theme.blue:
                emojis = ["💎","💎","🥏","🥏","🫐","🫐","🦋","🦋","🧿","🧿","🦕","🦕","👖","👖","🥶","🥶","🧢","🧢","❄️","❄️","🛝","🛝"]
                cardColor = Color.blue
            case Theme.round:
                emojis = ["💿","💿","🎾","🎾","🍪","🍪","🪙","🪙","🪩","🪩","🛞","🛞"]
                cardColor = Color.green
            }
            emojis.shuffle()
            overallTheme = theme
        }, label: {
            VStack {
                switch theme {
                case Theme.prickly:
                    Image(systemName: "pin.fill").font(.title)
                    Text("Game of poker?").font(.headline)
                case Theme.blue:
                    Image(systemName: "cloud.rain.fill").font(.title)
                    Text("Feeling blue?").font(.headline)
                case Theme.round:
                    Image(systemName: "circle.hexagongrid.fill").font(.title)
                    Text("U around?").font(.headline)
                }
            }
        }).disabled(theme == overallTheme)
    }
    /*
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
     */
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
