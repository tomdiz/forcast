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
    
    init(_ decoder: JSONDecoder) {
        
        icon = decoder["icon"].string
        summary = decoder["summary"].string
        temperatureMin = decoder["temperatureMin"].float
        temperatureMax = decoder["temperatureMax"].float
        time = decoder["time"].integer
    }
}
