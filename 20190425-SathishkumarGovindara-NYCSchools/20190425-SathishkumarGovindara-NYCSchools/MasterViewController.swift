//
//  MasterViewController.swift
//  20190425-SathishkumarGovindara-NYCSchools
//
//  Created by Sathish Kumar G on 4/24/19.
//  Copyright © 2019 Sathish Kumar G. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var schoolList = [Schools]() //Initialising Model Array

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "School List"
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
             fetchSchoolData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let currentSchool = schoolList[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = currentSchool
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    func fetchSchoolData() {
        let schoolURL = "https://data.cityofnewyork.us/api/id/f9bf-2cp4.json"
            Alamofire.request(schoolURL).responseData { (resData) -> Void in
                
                if((resData.result.value) != nil) {
                    let jsonArray = JSON(resData.result.value!)

                    guard let groups = jsonArray.array else {
                        self.somethingWrong()
                        return
                    }
                    for dic in groups{
                        let singleSchool = Schools.init(schoolName: dic["school_name"].string ?? "", schoolWebsite: dic["website"].string ?? "", totalStudents: dic["total_students"].string ?? "", mathScores: dic["sat_math_avg_score"].string ?? "", writingScore: dic["sat_writing_avg_score"].string ?? "", readingScore: dic["sat_critical_reading_avg_score"].string ?? "", testTakers: dic["num_of_sat_test_takers"].string ?? "")
                        self.schoolList.append(singleSchool) // adding new value in Model array
                    }
                    // reloading the table with new data
                    self.tableView.reloadData()
                }
            }
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //resuse cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let school = schoolList[indexPath.row] as Schools
        //setting the school names
        cell.textLabel!.text = school.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    func somethingWrong() {
        let alert = UIAlertController(title: "Error", message: "Oops, Something went wrong!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        //Show the alert on the screen
        self.present(alert, animated: true, completion: nil)
    }
}

