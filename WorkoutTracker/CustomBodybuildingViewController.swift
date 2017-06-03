//
//  CustomBodybuildingViewController.swift
//  WorkoutTracker
//
//  Created by Stefan Auvergne on 5/30/17.
//  Copyright © 2017 Stefan Auvergne. All rights reserved.
//

import UIKit

class CustomBodybuildingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var exName: UITextField!
    @IBOutlet weak var pickerOutlet: UIPickerView!
    @IBOutlet weak var add: UIButton!
    
    let exerciseKey:String = "exerciseKey"
    var myExercise = Exercise()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addExercise(_ sender: UIButton) {
        
        let id:Int = pickerOutlet.selectedRow(inComponent: 0)
        myExercise.name = exName.text!
        myExercise.category = types[id]
        
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "getExerciseID"), object: nil, userInfo: [exerciseKey:myExercise])
        
        dismiss(animated: true, completion: nil)
    }
}



