//
//  Category.swift
//  MoodTracker
//
//  Created by Asol on 1/23/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit
class Category{
    var name: String
    var color: UIColor
    
    init?(name: String, color: UIColor){
        // The name must not be empty
        guard !name.isEmpty else{
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.color = color
    }
}
