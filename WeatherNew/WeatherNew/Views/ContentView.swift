//
//  ContentView.swift
//  WeatherNew
//
//  Created by Dusan Vojinovic on 14.3.23..
//

import SwiftUI

struct ContentView: View {
    @StateObject var locatioManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locatioManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                              weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locatioManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locatioManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
