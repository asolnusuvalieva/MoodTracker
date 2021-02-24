import UIKit
import os.log
class Category: NSObject, NSCoding{
    //MARK: - Properties
    var name: String
    var color: UIColor
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("categories")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let color = "color"
    }
    
    init?(name: String, color: UIColor?){
        // The name must not be empty
        guard !name.isEmpty else{
            return nil
        }
        
        guard let validColor = color else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.color = validColor
    }
    
    //MARK: NSCoding
    func encode(with coder: NSCoder) { //encoding - property value with a unique key
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(color, forKey: PropertyKey.color)
    }
    
    required convenience init?(coder: NSCoder) { //decoding
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Category object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let color = coder.decodeObject(forKey: PropertyKey.color) as? UIColor else {
            os_log("Unable to decode the color for a Category object.", log: OSLog.default, type: .debug)
            return nil}
        
        //Must call designated initializer
        self.init(name: name, color: color)
    }
}
