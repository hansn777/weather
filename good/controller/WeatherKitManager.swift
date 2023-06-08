//
//  File.swift
//  good
//
//  Created by HyunwooPark on 2023/06/08.
//

import Foundation
import WeatherKit
import CoreLocation



@MainActor class WeatherKitManager: ObservableObject {
    
    @Published var weatherByDays: [WeatherByDay] = []
    func getCity(latitude: Double, longitude: Double) async -> String? {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let city = placemarks.first?.locality {
                print("City: \(city)")
                return city
            }
        } catch {
            print("Geocoding error: \(error)")
        }
        
        return nil
    }
    
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
                    filteredHourlyForecasts = hourlyForecasts.filter { forecast in
                        let forecastHour = calendar.component(.hour, from: forecast.date)
                        return forecastHour % 2 == 0
                    }
                } else {
                    filteredHourlyForecasts = hourlyForecasts.filter { forecast in
                        let forecastHour = calendar.component(.hour, from: forecast.date)
                        return forecastHour % 2 == 0
                    }
                }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:00"
                for hourForecast in filteredHourlyForecasts {
                    let time = dateFormatter.string(from: hourForecast.date)
                    let forecastByHour = ForecastByHour(temp: "\(Int(hourForecast.temperature.converted(to: .celsius).value))", weather: "\(hourForecast.condition)", time: time)
                    forecastsByHour.append(forecastByHour)
                }
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "MMMM, dd"
                let dateString = dateFormatter1.string(from: dayForecast.date)
                let weatherByDay = WeatherByDay(
                    weather: "\(dayForecast.condition)",
                    temp: "\(Int(weather.currentWeather.temperature.converted(to: .celsius).value))",
                    city: await getCity(latitude: latitude, longitude: longitude)!,
                    date: dateFormatter1.string(from: dayForecast.date),
                    max: "\(Int(dayForecast.highTemperature.converted(to: .celsius).value))",
                    min: "\(Int(dayForecast.lowTemperature.converted(to: .celsius).value))",
                    isToday: calendar.isDateInToday(dayForecast.date),
                    forecastByHour: forecastsByHour)
                weatherByDays.append(weatherByDay)
            }
            self.weatherByDays = weatherByDays
        } catch {
            fatalError("\(error)")
        }
    }
}
