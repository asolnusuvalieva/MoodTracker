//
//  CategoryViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/23/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit
import os.log

class CategoryViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Properties
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
    This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
    or constructed as part of adding a new meal.
    */
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { //gets called right after the method above
        navigationItem.title = name.text
    }
    
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
   // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let categoryName = name.text ?? ""
        let categoryColor: UIColor = .black
        category = Category(name: categoryName, color: categoryColor) //category or nil
    }
    

    //MARK: - Actions
    @IBAction func chooseColor(_ sender: UIButton) {
        // Hide the keyboard.
        name.resignFirstResponder()
    }
}
