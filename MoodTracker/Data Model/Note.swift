import UIKit
import os.log

class Note: NSObject, NSCoding{
    //MARK: - Properties
    var title: String
    var category: Category
    var text: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes")
    
    //MARK: Types
    struct PropertyKey{
        static let title = "title"
        static let category = "category"
        static let text = "text"

    }
    
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
    
    //MARK: NSCoding
    func encode(with coder: NSCoder) { //encoding: property value with a unique key
        coder.encode(title, forKey: PropertyKey.title)
        coder.encode(category, forKey: PropertyKey.category)
        coder.encode(text, forKey: PropertyKey.text)
    }
    
    required convenience init?(coder: NSCoder) { //decoding
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let title = coder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the title for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let category = coder.decodeObject(forKey: PropertyKey.category) as? Category else {
            os_log("Unable to decode the category for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let text = coder.decodeObject(forKey: PropertyKey.text) as? String else {
            os_log("Unable to decode the text for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //Must call designated initializer
        self.init(title: title, category: category, text: text)
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
