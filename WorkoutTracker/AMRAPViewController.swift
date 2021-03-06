//
//  AMRAPViewController.swift
//  WorkoutTracker
//
//  Created by Stefan Auvergne on 4/15/16.
//  Copyright © 2016 Stefan Auvergne. All rights reserved.
//
//  This controller allows the user to create an Amrap

import UIKit

class AmrapViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerOutlet: UIPickerView!
    @IBOutlet weak var backgroundImageOutlet: UIImageView!
    
    let exerciseKey:String = "exerciseKey"
    var myExercise = Exercise()
    var exerciseNumber:Int = 1
    var exerciseList:[String] = [""]
    var categoryPassed:String!
    
    let time = ["1 minute", "1min 30sec", "2 minutes", "2min 30sec", "3 minutes", "4 minutes", "5 minutes", "6 minutes", "7 minutes", "8 minutes", "9 minutes", "10 minutes", "15 minutes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = categoryPassed
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Have a Great Day Demo", size: 22)!,NSForegroundColorAttributeName: UIColor.darkText]
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.hitTest(_:)))
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hitTest(_ sender:UITapGestureRecognizer){
        if tableView.frame.contains(sender.location(in: view)){
            self.view.endEditing(true)
        }
    }
    
    func setCategory(category:String){
        categoryPassed = category
    }
    
    @IBAction func addExercise(_ sender: UIBarButtonItem) {
        exerciseNumber += 1
        exerciseList.append("")
        tableView.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return time[row]
    }

    @IBAction func addMetcon(_ sender: UIButton) {
        
        myExercise.name = "Amrap"
        let id:Int = pickerOutlet.selectedRow(inComponent: 0)
        var metconString = ""
        for exercise in exerciseList{
            if !exercise.isEmpty {
                metconString.append(exercise)
                metconString.append(" | ")
            }
        }
        
        myExercise.category = "Amrap"
        myExercise.type = "Crossfit"
        myExercise.exerciseDescription = (time[id] + " | " + metconString)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getExerciseID"), object: nil, userInfo: [exerciseKey:myExercise])
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AmrapCell", for: indexPath) as! AmrapCustomCell
        
        let text = exerciseList[(indexPath as NSIndexPath).row]
        
        cell.exTextField.text = text
        cell.exTextField.tag = (indexPath as NSIndexPath).row
        cell.exTextField.addTarget(self, action: #selector(MetconViewController.textFieldDidChange(_:)), for:UIControlEvents.editingChanged)
        
        return cell
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        let index = textField.tag
        exerciseList[index] = textField.text!
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
      
        label.text = time[row]
        
        let myTitle = NSAttributedString(string: label.text!, attributes: [NSFontAttributeName:UIFont(name: "Have a Great Day Demo", size: 21.0)!,NSForegroundColorAttributeName:UIColor.black])
        label.attributedText = myTitle
        label.textAlignment = NSTextAlignment.center
        
        return label
    }
    
}
