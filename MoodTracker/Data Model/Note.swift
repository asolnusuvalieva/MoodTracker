import UIKit
import os.log

class Note{
    //MARK: - Properties
    var title: String
    var category: Category
    var text: String
    
    init?(title: String, category: Category?, text: String){
        // The title must not be empty
        guard !title.isEmpty else{
            return nil
        }
        
        // The text must not be empty
        guard !text.isEmpty else {
            return nil
        }
        
        // The category must not be nil
        guard let validCategory = category else { // != nil
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.category = validCategory
        self.text = text
    }
    
}
/*
 The Logic Explanation:
 All properties of  a note must not be nil.
 
 When initializing a note,
 1) title != empty
 2) text != empty
 3) Category can be nil if user didn't choose anything. 
 */
