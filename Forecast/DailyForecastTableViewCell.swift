//
//  DailyForecastTableViewCell.swift
//  Forecast
//
//  Created by Thomas DiZoglio on 12/31/15.
//  Copyright © 2015 Thomas DiZoglio. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTempMin: UILabel!
    @IBOutlet weak var lblTempMax: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
}