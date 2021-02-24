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
        
        // The category must not be nil
        guard let validCategory = category else {
            return nil
        }
        
        // The text must not be empty
        guard !text.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.category = validCategory
        self.text = text
    }
    
}
