//
//  CategoryTableViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/22/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    //MARK: Properties
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        self.navigationItem.leftBarButtonItem = editButtonItem
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Load the sample data.
        loadSampleCategories()
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
        cell.categoryName.text = category.name
        cell.categoryColor.backgroundColor = category.color
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - Private Methods
    func loadSampleCategories(){
        guard let category1 = Category(name: "Wanna Die", color: .red) else{
            fatalError("Unable to instantiate category1")
        }
        
        guard let category2 = Category(name: "Life is Amazing", color: .yellow) else{
            fatalError("Unable to instantiate category2")
        }
        
        guard let category3 = Category(name: "Proud", color: .green) else{
            fatalError("Unable to instantiate category3")
        }
        
        categories += [category1, category2, category3]
    }

}
