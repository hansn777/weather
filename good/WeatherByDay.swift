//
//  DayWeather.swift
//  good
//
//  Created by hansn on 2023/06/05.
//

import Foundation

struct WeatherByDay: Hashable {
    var weather: String
    var temp: String
    var city: String
    var date: String
    var max: String
    var min: String
    var isToday: Bool
    var forecastByHour: [ForecastByHour]
}

struct ForecastByHour: Hashable {
    var temp: String
    var weather: String
    var time: String
}
