//
//  ViewController.swift
//  MedicationRec
//
//  Created by Ryan Padden on 11/12/18.
//  Copyright © 2018 Ryan Padden. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, DisplayScreenDelegate {
    

    let USER = "Ryan.Padden@uconn.edu"
    let PASSWORD = "E3tKmYZZ2!D4"
    let FHIR_PATIENT_URL = "https://fire-pit.mihin.org/pit-ct1/baseDstu3/Patient?"
    let FHIR_MED_URL = "https://fire-pit.mihin.org/pit-ct1/baseDstu3/MedicationRequest?"
    
    //Models
    var patientModel = patientDataModel()
    var medModel = medDataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupServer()
        errorDisplay.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var errorDisplay: UILabel!
    @IBOutlet weak var medNameBox: UITextField!
    @IBAction func medNameButton(_ sender: Any) {
        if medNameBox.text != nil{
            let fullNameArr = medNameBox.text!.components(separatedBy: " ")
            let param : [String : String] = ["given" : fullNameArr[0], "family" : fullNameArr[1]]
            getPatientData(url: FHIR_PATIENT_URL, parameters: param)
            
        }
    }
    
    
    func getPatientData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).authenticate(user: USER, password: PASSWORD).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success! Got the patient data")
                let patientJSON: JSON = JSON(response.result.value!)
                self.updatePatientData(json: patientJSON)
                
                let param : [String : String] = ["patient" : self.patientModel.id]
                self.getMedData(url: self.FHIR_MED_URL, parameters: param)
            }
            else{
                print("Error \(response.result.error!)")
                self.errorDisplay.text = "Error - enter new name"
                self.medNameBox.text = ""
            }
        }
    }
    
    func getMedData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).authenticate(user: USER, password: PASSWORD).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success! Got the med data")
                let medJSON: JSON = JSON(response.result.value!)
                self.updateMedData(json: medJSON)
            }
            else{
                print("Error \(response.result.error!)")
                self.errorDisplay.text = "Error - enter new name"
                self.medNameBox.text = ""
            }
        }
        
    }
    
    func updatePatientData(json: JSON){
        patientModel.id = json["entry"][0]["resource"]["id"].stringValue
        patientModel.name = json["entry"][0]["resource"]["name"][0]["given"][0].stringValue + " " + json["entry"][0]["resource"]["name"][0]["given"][1].stringValue + " " + json["entry"][0]["resource"]["name"][0]["family"].stringValue
        print(patientModel.id)
        print(patientModel.name)
    }
    
    func updateMedData(json: JSON){
        medModel.total = json["total"].int!
        for index in 0...(medModel.total-1){
            medModel.name.append(json["entry"][index]["resource"]["medicationCodeableConcept"]["coding"][0]["display"].stringValue)
            medModel.code.append(json["entry"][index]["resource"]["medicationCodeableConcept"]["coding"][0]["code"].stringValue)
            if let reason = json["entry"][index]["resource"]["reasonCode"][0]["coding"][0]["display"].string {
                medModel.reason.append(reason)
            }else{
                medModel.reason.append("N/A")
            }
            print(index)
            print(medModel.name[index])
            print(medModel.code[index])
            print(medModel.reason[index])
        }
        self.performSegue(withIdentifier: "displayScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayScreen"{
            let displayVC = segue.destination as! DisplayScreen
            displayVC.delegate = self
            displayVC.mM = medModel
            displayVC.pM = patientModel
            
        }
    }
    
    func userHitBack() {
        medNameBox.text = ""
        patientModel.clean()
        medModel.clean()
    }
    
}
