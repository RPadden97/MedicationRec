//
//  ArticleModel.swift
//  MedicationRec
//
//  Created by Ryan Padden on 12/3/18.
//  Copyright © 2018 Ryan Padden. All rights reserved.
//

import Foundation
import UIKit

class patientDataModel{
    var id : String = ""
    var name : String = ""
    
    func clean(){
        self.id = ""
        self.name = ""
    }
    
}


class medDataModel{
    var total : Int = 0
    var name : [String] = []
    var code : [String] = []
    var reason : [String] = []
    
    func clean(){
        self.total = 0
        self.name = []
        self.code = []
        self.reason = []
    }
    
}

