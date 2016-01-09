//
//  ViewController.swift
//  Forecast
//
//  Created by Thomas DiZoglio on 12/31/15.
//  Copyright © 2015 Thomas DiZoglio. All rights reserved.
//

import UIKit
import Alamofire
import JSONJoy


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblTempurature: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var tblDailyForcasts: UITableView!
    @IBOutlet weak var indLoading: UIActivityIndicatorView!

    var dailys: DailyForecasts? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.indLoading.startAnimating()

        Alamofire.request(.GET, "https://api.forecast.io/forecast/API_KEY_HERE/42.366978,-71.022362")
            .responseJSON { response in
                print(response.request)  // original URL request
                
                if let JSON = response.result.value {
                    
                    print("JSON: \(JSON)")

                    // Current forcast
                    let current = CurrentForecast(JSONDecoder(response.data!))

                    self.lblSummary.text = current.summary
                    self.lblTempurature.text = String(Int(current.temperature!)) + "\u{00B0}"
                    self.imgIcon.image = current.getIcon()

                    // Forcast next 5 days
                    self.dailys = DailyForecasts(JSONDecoder(response.data!))
                    
                    self.tblDailyForcasts.reloadData()
                    
                    self.indLoading.stopAnimating()
                }
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (dailys == nil) {
            
            return 0
        }
        else {
            
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("daily_forcast_cell", forIndexPath: indexPath) as! DailyForecastTableViewCell
        let forecast = dailys?.dailyforecasts![indexPath.row]
        cell.lblTempMin.text = String(Int((forecast?.temperatureMin!)!)) + "\u{00B0}"
        cell.lblTempMax.text = String(Int((forecast?.temperatureMax!)!)) + "\u{00B0}"
        cell.lblSummary.text = forecast?.summary
        return cell
    }
}

