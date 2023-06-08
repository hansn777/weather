//
//  File.swift
//  good
//
//  Created by HyunwooPark on 2023/06/08.
//

import Foundation
import WeatherKit

@MainActor class WeatherKitManager: ObservableObject {
    
    @Published var weatherByDays: [WeatherByDay] = []
    
    func getWeather(latitude: Double, longitude: Double) async {
        do {
            let weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }.value

            let calendar = Calendar.current
            var weatherByDays: [WeatherByDay] = []
            let groupedHourlyForecast = Dictionary(grouping: weather.hourlyForecast) { forecast in
                calendar.startOfDay(for: forecast.date)
            }
            for dayForecast in weather.dailyForecast {
                var forecastsByHour: [ForecastByHour] = []
                let hourlyForecasts = groupedHourlyForecast[calendar.startOfDay(for: dayForecast.date)] ?? []
                let filteredHourlyForecasts: [HourWeather]
                if calendar.isDateInToday(dayForecast.date) {
                    let currentHour = calendar.component(.hour, from: Date())
                    filteredHourlyForecasts = hourlyForecasts.filter { forecast in
                        let forecastHour = calendar.component(.hour, from: forecast.date)
                        return forecastHour >= currentHour && forecastHour < currentHour + 10 && forecastHour % 2 == currentHour % 2
                    }
                } else {
                    filteredHourlyForecasts = hourlyForecasts.filter { forecast in
                        let forecastHour = calendar.component(.hour, from: forecast.date)
                        return forecastHour < 10 && forecastHour % 2 == 0
                    }
                }
                for hourForecast in filteredHourlyForecasts.prefix(5) {
                    let forecastByHour = ForecastByHour(temp: "\(hourForecast.temperature)", weather: "\(hourForecast.condition)", time: "\(hourForecast.date)")
                    forecastsByHour.append(forecastByHour)
                }
                let weatherByDay = WeatherByDay(weather: "\(dayForecast.condition)", temp: "1", city: "San Francisco", date: "\(dayForecast.date)", max: "\(dayForecast.highTemperature)", min: "\(dayForecast.lowTemperature)", isToday: calendar.isDateInToday(dayForecast.date), forecastByHour: forecastsByHour)
                weatherByDays.append(weatherByDay)
            }
            self.weatherByDays = weatherByDays
        } catch {
            fatalError("\(error)")
        }
    }
}

