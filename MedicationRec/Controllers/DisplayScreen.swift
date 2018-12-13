//
//  DisplayScreen.swift
//  MedicationRec
//
//  Created by Ryan Padden on 12/12/18.
//  Copyright © 2018 Ryan Padden. All rights reserved.
//

import UIKit

protocol DisplayScreenDelegate{
    func userHitBack ()
}

class DisplayScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var delegate : DisplayScreenDelegate?
    
    var pM : patientDataModel = patientDataModel()
    var mM : medDataModel = medDataModel()
    let duh = ["1","2"]
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pM.name
        mM.name.sort()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userHitBack(){
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mM.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = mM.name[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 12)
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
