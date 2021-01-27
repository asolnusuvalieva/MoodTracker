//
//  CategoryViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/23/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit
import os.log

class CategoryViewController: UIViewController, UITextFieldDelegate, UIColorPickerViewControllerDelegate {
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
        
        //handle the textField's user input through delegate callbacks.
        name.delegate = self
        
        // Enable the Save button only if the text field has a valid Category name.
        updateSaveButtonState()
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { //gets called right after the method above
        navigationItem.title = name.text
    }
    
    //MARK: - UIColorPickerViewControllerDelegate
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        //Informs the delegate when the user selects a color. Called on every color selection done in the picker.
        colorLabel.backgroundColor = viewController.selectedColor
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        //Informs the delegate that the user dismissed the view controller. Called once you have finished picking the color.
        colorLabel.backgroundColor = viewController.selectedColor
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
        let categoryColor: UIColor = colorLabel.backgroundColor ?? .systemGray2
        category = Category(name: categoryName, color: categoryColor) //category or nil
    }
    

    //MARK: - Actions
    @IBAction func selectColor(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        name.resignFirstResponder()
        
        if #available(iOS 14.0, *) {
            //UIColorPickerViewController is a view controller that informs your app about user interaction with the color picker.
            let colorPicker = UIColorPickerViewController()
            
            //setting the Initial color of the Picker
            colorPicker.selectedColor = .systemGray2
            
            // Make sure CategoryViewController is notified when the user picks an image.
            colorPicker.delegate = self
            
            // Presenting the Color Picker
            present(colorPicker, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: - Private Methods
    private func updateSaveButtonState(){
        // Disable the Save button if the text field is empty.
        let text = name.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
