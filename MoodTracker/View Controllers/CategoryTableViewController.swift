//
//  CategoryTableViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/22/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit
import os.log

class CategoryTableViewController: UITableViewController {
    //MARK: Properties
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedCategories = loadCategories(){
            categories += savedCategories
        }else{
            //Load the sample data
            loadSampleCategories()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CategoryTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of CategoryTableViewCell.")
        }
        
        // Fetches the appropriate category for the data source layout.
        let category = categories[indexPath.row]
        cell.name.text = category.name
        cell.colorLabel.backgroundColor = category.color

        return cell
    }
    
    //MARK: - TableView Editing

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            categories.remove(at: indexPath.row)
            saveCategories()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "addCategory":
            os_log("Adding a new category.", log: OSLog.default, type: .debug)
        case "editCategory":
            guard let categoryViewController = segue.destination as? CategoryViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCategoryCell = sender as? CategoryTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCategoryCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let category = categories[indexPath.row]
            categoryViewController.category = category
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: - Actions
    @IBAction func unwindToCategoryList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? CategoryViewController, let category = sourceViewController.category {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an existing category
                categories[selectedIndexPath.row] = category
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                // Add a new category.
                let newIndexPath = IndexPath(row: categories.count, section: 0)
                categories.append(category)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //Save categories
            saveCategories()
        }
    }
    
    
    //MARK: - Private Methods
    func loadSampleCategories(){
        guard let category1 = Category(name: "Wanna Die", color: .red) else{
            fatalError("Unable to instantiate category1")
        }
        
        guard let category2 = Category(name: "Life is Amazing", color: .yellow) else{
            fatalError("Unable to instantiate category2")
        }
        
        guard let category3 = Category(name: "Feeling proud", color: .green) else{
            fatalError("Unable to instantiate category3")
        }
        guard let category4 = Category(name: "Feeling so inspired", color: .blue)else{
            fatalError("Unable to instantiate category4")
        }
        
        categories += [category1, category2, category3, category4]
    }
    
    private func saveCategories(){
        //Archiving
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(categories, toFile: Category.ArchiveURL.path)
        if isSuccessfulSave{
            os_log("Categories successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save categories...", log: OSLog.default, type: .error)
        }
    }
    private func loadCategories() -> [Category]?{
        //Unarchiving
        return NSKeyedUnarchiver.unarchiveObject(withFile: Category.ArchiveURL.path) as? [Category]
    }

}
