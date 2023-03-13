//
//  ContentView.swift
//  WeatherNew
//
//  Created by Dusan Vojinovic on 14.3.23..
//

import SwiftUI

struct ContentView: View {
    @StateObject var locatioManager = LocationManager()
    
    
    var body: some View {
        VStack {
            
            if let location = locatioManager.location {
                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
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
