import UIKit
//SHOULD RETURN NoteCategory

class NoteCategoriesTableViewController: UITableViewController, UINavigationControllerDelegate {
    //MARK: - Properties
    var noteCategories = [Category]()
    var noteCategory: Category? //a user may not choose anything and navigate back
    
    var selectedSection = -1
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        if let categoryTableViewController = storyboard?.instantiateViewController(withIdentifier: "categoryTableViewController") as? CategoryTableViewController{
            categoryTableViewController.viewDidLoad()
            noteCategories = categoryTableViewController.categories
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteCategories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoteCategoriesTableViewControllerCell"
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteCategoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of NoteCategoryTableViewCell.")
        }

        // Fetches the appropriate category for the data source layout.
        let noteCategory = noteCategories[indexPath.row]
        cell.name.text = noteCategory.name
        cell.colorLabel.backgroundColor = noteCategory.color
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            if let oldCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: selectedSection)){
                oldCell.accessoryType = .none
            }
            return indexPath
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        noteCategory = noteCategories[indexPath.row]
        
        selectedSection = indexPath.section
        selectedRow = indexPath.row
    }
    
    
    //MARK: - UINavigationController Delegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let validNoteCategory = noteCategory else{return}
        guard let noteViewController = viewController as? NoteViewController else{return}
       
        noteViewController.colorLabel.backgroundColor = validNoteCategory.color
        noteViewController.categoryLabel.text = validNoteCategory.name
    }

}
