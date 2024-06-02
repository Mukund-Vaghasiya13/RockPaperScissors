//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mukund vaghasiya  on 01/06/24.
//

import SwiftUI


struct Item:Identifiable{
    let id = UUID()
    var item:String
}

struct ContentView: View {
    
    
    let itemOfCard = [Item(item: "🪨"),Item(item: "📃"),Item(item: "✂️"),Item(item: "✏️")]
    @State var Computer:String = "🪨"
    @State var you = "🪨"
    @State var disableAllButton = false
    @State var result = ""

    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                VStack(spacing:30){
                    Text(result)
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                    
                    HStack{
                        CardView(title: "Computer", itCanBeYouOrComputer: $Computer)
                        
                        Text("V/S")
                            .bold()
                        
                        CardView(title: "You", itCanBeYouOrComputer: $you)
                    }
                    
                    Text("Select any Item form bellow")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.top,30)
                    
                    HStack{
                        
                        ForEach(itemOfCard, id: \.id) { i in
                            Button(action: {
                                disableAllButton = true
                                withAnimation(.bouncy) {
                                    you = i.item
                                    Computer = itemOfCard.randomElement()!.item
                                }
                                
                                resultChecking()
                            
                            }, label: {
                                Text(i.item)
                                    .font(.system(size: 50))
                                    .frame(width: 85,height: 95)
                                    .background(.green)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            }).disabled(disableAllButton)
                        }
                        
                    }
                    .padding()
                
                    
                    Button(action: {
                        result = ""
                        you = "🪨"
                        Computer = "🪨"
                        disableAllButton = false
                    }, label: {
                        Text("New Game")
                            .frame(width: 200,height: 55)
                            .background(.black)
                            .foregroundStyle(.white)
                            .font(.system(size: 25,weight: .heavy))
                            .cornerRadius(10)
                    })
                }
                .navigationTitle("Game")
            .padding()
            }
        }
    }
    
    func resultChecking(){
        if you == Computer{
            result = "draw"
        }else if (you == "✂️" && Computer == "📃") || (you == "✏️" && Computer == "📃") || (you == "🪨" && Computer == "✂️") || (you == "🪨" && Computer == "✏️") || (you == "✂️" && Computer == "✏️"){
            result = "You Win"
        }else{
            result = "Computer Win"
        }
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    var title:String
    @Binding var itCanBeYouOrComputer:String
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 25))
                .fontWeight(.bold)
            Text(itCanBeYouOrComputer)
                .font(.system(size: 100))
        }
        .frame(width: 140,height: 150)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


