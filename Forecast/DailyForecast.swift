//
//  DailyForecast.swift
//  Forecast
//
//  Created by Thomas DiZoglio on 12/31/15.
//  Copyright © 2015 Thomas DiZoglio. All rights reserved.
//

import Foundation
import JSONJoy

struct DailyForecast : JSONJoy {
    
    var icon: String?
    var summary: String?
    var temperatureMin: Float?
    var temperatureMax: Float?
    var time: Int?
    
    init() {
        
    }
    
    init(_ decoder: JSONDecoder) throws {
        
        icon = try decoder["icon"].get()
        summary = try decoder["summary"].get()
        temperatureMin = try decoder["temperatureMin"].get()
        temperatureMax = try decoder["temperatureMax"].get()
        time = try decoder["time"].get()
    }
}
