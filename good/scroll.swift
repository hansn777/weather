//
//  scroll.swift
//  good
//
//  Created by hansn on 2023/06/05.
//

import Foundation
import SwiftUI

struct ContenttView: View {
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
                .padding(.bottom, 710)}
            
            ScrollView {
                HStack {
                    PageView()
                }
            }
        }
    }
}


struct PageView: View {
    var days:[Dayweather] = [
        Dayweather(
            weather: "rain",
            temp: "22",
            city: "Goyang-Ilsan",
            date: "june,21",
            max: "33",
            min: "33",
            isToday: true,
            forcestByhour: [
                ForecastByHour(temp: "11", weather: "cloud", time: "14:00"),
                ForecastByHour(temp: "11", weather: "cloud", time: "14:00"),
                ForecastByHour(temp: "11", weather: "cloud", time: "14:00"),
                ForecastByHour(temp: "11", weather: "cloud", time: "14:00"),
                ForecastByHour(temp: "11", weather: "cloud", time: "14:00")
            ]
        ),
        Dayweather(
            weather: "foggy",
            temp: "22",
            city: "seould",
            date: "jucne",
            max: "33",
            min: "33",
            isToday: false,
            forcestByhour: [ForecastByHour(temp: "11", weather: "cloud", time: "14:00")]
        ),
        Dayweather(
            weather: "clear",
            temp: "22",
            city: "seould",
            date: "judne",
            max: "33",
            min: "33",
            isToday: false,
            forcestByhour: [ForecastByHour(temp: "11", weather: "cloud", time: "14:00")]
        ),
        Dayweather(
            weather: "mostly clear",
            temp: "22",
            city: "seould",
            date: "junee",
            max: "33",
            min: "33",
            isToday: false,
            forcestByhour: [ForecastByHour(temp: "11", weather: "cloud", time: "14:00")]
        ),
        Dayweather(
            weather: "thunderstorms",
            temp: "22",
            city: "seould",
            date: "jusne",
            max: "10",
            min: "33",
            isToday: false,
            forcestByhour: [ForecastByHour(temp: "11", weather: "cloud", time: "14:00")]
        ),
        Dayweather(
            weather: "snow",
            temp: "22",
            city: "seould",
            date: "jusne",
            max: "-1",
            min: "43",
            isToday: false,
            forcestByhour: [ForecastByHour(temp: "11", weather: "cloud", time: "14:00")]
        ),
        Dayweather(
            weather: "partly cloudy",
            temp: "22",
            city: "seould",
            date: "jusne",
            max: "3",
            min: "1",
            isToday: false,
            forcestByhour: [ForecastByHour(temp: "11", weather: "cloud", time: "14:00")]
        ),
    ]
    var body: some View {
        TabView {
            
            ForEach(days, id: \.self) {
                day in
                VStack{
                    VStack{
                        //                        Text(day.weather)
                        //                            .font(.title3)
                        //                            .fontWeight(.medium)
                        //                            .foregroundColor(.white)
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
                                
                                //                                .fixedSize()
                                HStack{
                                    HStack{
                                        Spacer()
                                        VStack{
                                            Text("최저")
                                                .font(.system(size:20))
                                                .fontWeight(.medium)
                                                .foregroundColor(.blue)
                                                .padding(.trailing, 15)
                                            
                                            HStack{ Text(day.max)
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
                                            HStack{ Text(day.min)
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
                        .padding(.bottom, 55)
                    HStack{
                        ForEach(day.forcestByhour, id: \.self) { forecast in
                            VStack(spacing: 6.0){
                                Text(forecast.time)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                
                                Image("bottom ex")
                                Text("\(forecast.temp)°")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
//                            Spacer()
                        }
                    }
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("bottom back"))
                            .padding(.horizontal, 18)
                            .padding(.vertical, -15.0))
                }
            }
            .padding(.top,5)
            //            .padding(0)
            //            .padding(.all)
        }
        .background{
            Image("map")}.padding(.bottom, 20)
            .frame(width: UIScreen.main.bounds.width, height: 780)
            .tabViewStyle(PageTabViewStyle())
        
    }
}


struct ContenttView_Previews: PreviewProvider {
    static var previews: some View {
        ContenttView()
    }
}
