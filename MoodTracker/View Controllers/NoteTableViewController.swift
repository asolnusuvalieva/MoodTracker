//
//  NoteTableViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/22/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    //MARK: - Properties
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.leftBarButtonItem = self.editButtonItem //system edit button in the navigation bar for editing the table view
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoteTableViewCell"
        // Table view cells are reused and should be dequeued using a cell identifier.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell.")
        }
    
        // Fetches the appropriate note for the data source layout.
        let note = notes[indexPath.row]
        cell.title.text = note.title
        cell.textExtract.text = note.text //FIXME
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
