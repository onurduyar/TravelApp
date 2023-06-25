//
//  CardView.swift
//  TravelApp
//
//  Created by Onur Duyar on 25.06.2023.
//

import SwiftUI

class SelectedWeatherStore: ObservableObject {
    @Published var selectedWeather: WeatherElement?
}

struct CardView: View {
    @ObservedObject var selectedWeatherStore = SelectedWeatherStore()
    
    var body: some View {
        ZStack {
            if selectedWeatherStore.selectedWeather == nil {
            } else {
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 4.0, x: 0, y: 2)
                VStack(spacing: 8) {
                    HStack {
                        Spacer()
                        Image("location_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        Text(selectedWeatherStore.selectedWeather?.name ?? "")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                            .padding(5)
                    }
                    
                    Text("Today's Weather")
                        .font(.system(size: 16, weight: .bold))
                    
                    Image(systemName: selectedWeatherStore.selectedWeather?.weather?[0].conditionName ?? "cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                    HStack {
                        Text(String(format: "%.1f C", selectedWeatherStore.selectedWeather?.main?.feelsLike ?? 0.0))
                            .font(.system(size: 40))
                            .padding(.trailing, 30)
                        
                        Text(selectedWeatherStore.selectedWeather?.weather?[0].description ?? "")
                            .font(.system(size: 12))
                            .textCase(.uppercase)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                    
                    HStack {
                        WeatherCardView(title: "Humidity", value: String(format: "%%%d", selectedWeatherStore.selectedWeather?.main?.humidity ?? 0), color: Color.blue, image: "humidity")
                        
                        WeatherCardView(title: "Wind", value: String(format: "%.2f km/h", selectedWeatherStore.selectedWeather?.wind?.speed ?? 0), color: Color.green, image: "wind")
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .frame(height: 200)
    }
}

struct ContentView: View {
    var body: some View {
        CardView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherCardView: View {
    var title: String
    var value: String
    var color: Color
    var image: String
    
    var body: some View {
        HStack(content: {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            VStack {
                Text(title)
                    .font(.system(size: 12))
                    .bold()
                
                Text(value)
                    .font(.system(size: 12, weight: .bold))
            }
        })
        .padding(8)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}
