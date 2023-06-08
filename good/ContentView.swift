//
//  ContentView.swift
//  good
//
//  Created by hansn on 2023/06/04.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color("backcolor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                }
                .padding(.horizontal, 24.0)
                .padding(.top, 18.0)
                
                Spacer()
                
            }
            VStack{
                VStack{
                    Text("날씨정보")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    HStack{
                        Text("23")
                            .font(.system(size: 100))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Image(systemName: "circle")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .padding(.bottom, 46.0)
                            .padding(.leading,-9.0)
                    }
                    .padding(.leading, 28.0)
                    .padding(.bottom,0)
                    
                    Text("위치")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,-65)
                    
                    Text("오늘 날짜")
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(Color("date color"))
                        .padding(.top,-45)
                    
                    //                    Image("cloud")
                }
                .background{
                    Image("map")
                }
                Image("cloud")
                Spacer()
            }
            .padding(.top,65)
                    }
                }
            }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
