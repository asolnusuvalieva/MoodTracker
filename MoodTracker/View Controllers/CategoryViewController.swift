//
//  CategoryViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/23/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    //MARK: - Actions
    @IBAction func chooseColor(_ sender: UIButton) {
        // Hide the keyboard.
        name.resignFirstResponder()
    }
}
