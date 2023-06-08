//
//  scroll.swift
//  good
//
//  Created by hansn on 2023/06/05.
//

import Foundation
import SwiftUI

struct ContenttView: View {
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationDataManager = LocationDataManager()
    var body: some View {
            ZStack{
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
                    .padding(.bottom, 720)
                }
                
                HStack {
                    GeometryReader { geometry in
                        PageView(days: weatherKitManager.weatherByDays)
                            .task {
                                await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                
            }
        }
        
        
        struct PageView: View {
            var days:[WeatherByDay]
            var body: some View {
                TabView {
                    
                    ForEach(days, id: \.self) {
                        day in
                        GeometryReader { geometry in
                            VStack{
                                VStack{
                                    if(day.isToday){
                                        HStack{
                                            
                                            Text(day.temp)
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
                                    }
                                    
                                    else{
                                        ZStack{
                                            HStack{
                                                HStack{
                                                    Spacer()
                                                    VStack{
                                                        Text("최저")
                                                            .font(.system(size:20))
                                                            .fontWeight(.medium)
                                                            .foregroundColor(.blue)
                                                            .padding(.trailing, 15)
                                                        
                                                        HStack{
                                                            Text(day.min)
                                                                .font(.system(size: 80))
                                                                .fontWeight(.medium)
                                                                .foregroundColor(.white)
                                                            
                                                            Image(systemName: "circle")
                                                                .foregroundColor(.white)
                                                                .fontWeight(.black)
                                                                .padding(.bottom, 46.0)
                                                            .padding (.leading,-9.0)}
                                                        .padding(.top, -20)
                                                    }
                                                    .padding(.trailing, -40)
                                                    
                                                    Spacer()
                                                }
                                                Image("center line")
                                                    .padding(.top, 10)
                                                HStack{
                                                    Spacer()
                                                    VStack{
                                                        Text("최고")
                                                            .font(.system(size:20))
                                                            .fontWeight(.medium)
                                                            .padding(.trailing, 15)
                                                            .foregroundColor(.red)
                                                        HStack{
                                                            Text(day.max)
                                                                .font(.system(size: 80))
                                                                .fontWeight(.medium)
                                                                .foregroundColor(.white)
                                                            
                                                            Image(systemName: "circle")
                                                                .foregroundColor(.white)
                                                                .fontWeight(.black)
                                                                .padding(.bottom, 46.0)
                                                            .padding (.leading,-9.0)}
                                                        .padding(.top, -20)
                                                        
                                                    }
                                                    .padding(.leading, -30)
                                                    Spacer()
                                                }
                                            }
                                            .padding(.leading,10.0)
                                            .padding(.bottom,45)
                                            .padding(.top, 13.7)
                                        }
                                    }
                                    Text(day.city)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.top,-65)
                                    
                                    Text(day.date)
                                        .font(.body)
                                        .fontWeight(.light)
                                        .foregroundColor(Color("date color"))
                                        .padding(.top,-45)
                                    
                                }
                                Image(day.weather)
                                    .padding(.bottom, 65)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack{
                                        ForEach(day.forecastByHour, id: \.self) { forecast in
                                            VStack(spacing: 1.0){
                                                Text(forecast.time)
                                                    .font(.caption2)
                                                    .foregroundColor(.white)
                                                Image("\(forecast.weather)_b")
                                                Text("\(forecast.temp)°")
                                                    .font(.title2)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.white)
                                                    .padding(.leading, 5)
                                            }
                                        }.padding(.horizontal,1)
                                    }
                                }
                                .padding(.horizontal, 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("bottom back"))
                                        .padding(.horizontal, 19)
                                        .padding(.vertical, -18.0))
                            }.padding(.bottom, 80)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .padding(.top,40)
                }
                .background{
                    Image("map")}.padding(.bottom, 20)
                    .frame(width: UIScreen.main.bounds.width, height: 790)
                    .tabViewStyle(PageTabViewStyle())
                
            }
        }
        
        
        struct ContenttView_Previews: PreviewProvider {
            static var previews: some View {
                ContenttView()
            }
        }
    }
