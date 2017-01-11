//
//  DailyForcasts.swift
//  Forecast
//
//  Created by Thomas DiZoglio on 12/31/15.
//  Copyright © 2015 Thomas DiZoglio. All rights reserved.
//

import Foundation
import JSONJoy

struct DailyForecasts : JSONJoy {

    var dailyforecasts: Array<DailyForecast>?

    init() {
        
    }
    
    init(_ decoder: JSONDecoder) throws {
        
        let forcasts = decoder["daily"]["data"].getOptionalArray()
        dailyforecasts = Array<DailyForecast>()
        for forecastDecoder in forcasts! {
            
            dailyforecasts?.append(try DailyForecast(forecastDecoder))
        }
    }
}
