//
//  DetailViewController.swift
//  20190425-SathishkumarGovindara-NYCSchools
//
//  Created by Sathish Kumar G on 4/24/19.
//  Copyright © 2019 Sathish Kumar G. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var satMathLabel: UILabel!
    @IBOutlet weak var satReadingLabel: UILabel!
    @IBOutlet weak var satWritingLabel: UILabel!
    @IBOutlet weak var testTakersLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                // setting the values on UI
                label.text = detail.website
                satMathLabel.text = detail.math
                satReadingLabel.text = detail.reading
                satWritingLabel.text = detail.writing
                schoolNameLabel.text = detail.name
                testTakersLabel.text = detail.totalTestTakers
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Schools? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

