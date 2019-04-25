//
//  School.swift
//  20190425-SathishkumarGovindara-NYCSchools
//
//  Created by Sathish Kumar G on 4/25/19.
//  Copyright © 2019 Sathish Kumar G. All rights reserved.
//

import Foundation

public class Schools {
    
    let name : String
    let website : String
    let numberOfStudents : String
    //scores
    let math : String
    let writing : String
    let reading : String
    let totalTestTakers : String
    
    init(schoolName : String, schoolWebsite: String, totalStudents : String, mathScores: String, writingScore : String, readingScore : String, testTakers : String) {
        name = schoolName
        website = schoolWebsite
        numberOfStudents = totalStudents
        math = mathScores
        writing = writingScore
        reading = readingScore
        totalTestTakers = testTakers
    }
}
