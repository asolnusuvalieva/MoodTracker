//
//  NoteTableViewController.swift
//  MoodTracker
//
//  Created by Asol on 2/9/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

class NoteViewController: UITableViewController, UITextViewDelegate {
    //MARK: Properties
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textTextView:UITextView!
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle the textView's user input through delegate callbacks.
        titleTextView.delegate = self
        textTextView.delegate = self
        
        //Adding done button in the tool bar for textTextView
        textTextView.addDoneButton()
    }
    
    //MARK: - TextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        //during editing `saveButton` should be disabled
        if textView == titleTextView || textView == textTextView{
            saveButton.isEnabled = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //in case of titleTextView, the keyboard should be dismissed when `return` is tapped
        if(textView == titleTextView && text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
        navigationItem.title = titleTextView.text
    }
    
    // MARK: - Table View
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        if indexPath.section == 0 && indexPath.row == 1{
//            print("Doing right")
//            performSegue(withIdentifier: "NewNoteCategoryChoosing", sender: self)
//        }
//    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //MARK: - Actions
    
    
    //MARK: - Private Methods
    private func updateSaveButtonState(){
        //Disable the Save button if the title and text are empty.
        let title = titleTextView.text ?? ""
        let text = textTextView.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !title.isEmpty
    }
}
