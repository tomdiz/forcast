//
//  CurrentForecast.swift
//  Forecast
//
//  Created by Thomas DiZoglio on 12/31/15.
//  Copyright © 2015 Thomas DiZoglio. All rights reserved.
//

import Foundation
import JSONJoy

struct CurrentForecast : JSONJoy {
    
    var apparentTemperature: Float?
    var icon: String?
    var summary: String?
    var temperature: Float?
    var time: Int?
    
    init() {
        
    }

    init(_ decoder: JSONDecoder) throws {

        apparentTemperature = try decoder["currently"]["apparentTemperature"].get()
        icon = try decoder["currently"]["icon"].get()
        summary = try decoder["currently"]["summary"].get()
        temperature = try decoder["currently"]["temperature"].get()
        time = try decoder["currently"]["time"].get()
    }
    
    func getIcon() -> UIImage {
        
        print("icon = " + self.icon!)
        if (self.icon!.isEqual("cloudy")) {
            
            return UIImage(named: "cloudy")!
        }
        else if (self.icon!.isEqual("partly-cloudy-day")) {
            
            return UIImage(named: "partly-cloudy-day")!
        }
        else if (self.icon!.isEqual("fog")) {
            
            return UIImage(named: "fog")!
        }
        else if (self.icon!.isEqual("sleet")) {
            
            return UIImage(named: "sleet")!
        }
        else if (self.icon!.isEqual("rain")) {
            
            return UIImage(named: "rain")!
        }
        else if (self.icon!.isEqual("wind")) {
            
            return UIImage(named: "wind")!
        }
        else if (self.icon!.isEqual("clear-night")) {
            
            return UIImage(named: "clear-night")!
        }
        else if (self.icon!.isEqual("partly-cloudy-night")) {
            
            return UIImage(named: "partly-cloudy-night")!
        }
        else if (self.icon!.isEqual("snow")) {
            
            return UIImage(named: "snow")!
        }
        else {
            
            return UIImage(named: "clear-day")!
        }
    }
}
