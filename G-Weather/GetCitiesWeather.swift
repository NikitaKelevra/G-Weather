//
//  GetCitiesWeather.swift
//  G-Weather
//
//  Created by Сперанский Никита on 20.02.2022.
//

import Foundation
import CoreLocation

let networkManager = NetworkManager()

func getCiyWeather(citiesArray: [String], completionHandler: @escaping(Int, Weather) -> Void) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }
            
            networkManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                completionHandler(index,weather)
            }

        }
    }
    
}

func getCoordinateFrom(city:String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
