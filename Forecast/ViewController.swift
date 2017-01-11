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

        Alamofire.request("https://api.forecast.io/forecast/API_KEY_HERE/42.366978,-71.022362", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let JSON = response.result.value {
                    
                    //print("JSON: \(JSON)")
                    
                    // Current forcast
                    do {

                        let current = try CurrentForecast(JSONDecoder(response.data!))
                        self.lblSummary.text = current.summary
                        self.lblTempurature.text = String(Int(current.temperature!)) + "\u{00B0}"
                        self.imgIcon.image = current.getIcon()
                    } catch {
                        
                        print("Error getting forcast from server!")
                    }

                    // Forcast next 5 days
                    do {
                        
                        self.dailys = try DailyForecasts(JSONDecoder(response.data!))
                    } catch {
                        
                        print("Error getting 5 day forcast from server!")
                    }
                    
                    self.tblDailyForcasts.reloadData()
                    
                    self.indLoading.stopAnimating()
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                break
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (dailys == nil) {
            
            return 0
        }
        else {
            
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "daily_forcast_cell", for: indexPath) as! DailyForecastTableViewCell
        let forecast = dailys?.dailyforecasts![indexPath.row]
        cell.lblTempMin.text = String(Int((forecast?.temperatureMin!)!)) + "\u{00B0}"
        cell.lblTempMax.text = String(Int((forecast?.temperatureMax!)!)) + "\u{00B0}"
        cell.lblSummary.text = forecast?.summary
        return cell
    }
}

