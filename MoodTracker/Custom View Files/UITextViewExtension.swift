//
//  UITextViewExtension.swift
//  MoodTracker
//
//  Created by Asol on 2/16/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit
extension UITextView{
    func addDoneButton(){
        //Creating a tool bar
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        
        //Creating a UIBarButtonItem of type flexibleSpace
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //Creating UIBarButtonItem
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        
        //Assigning these two UIBarButtonItems to toolBar
        toolBar.setItems([space, doneButton], animated: false)
        
        //Setting this toolBar as inputAccessoryView to the UITextView
        self.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(){
        self.endEditing(true)
    }
}
