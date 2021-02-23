//
//  NoteTableViewController.swift
//  MoodTracker
//
//  Created by Asol on 1/22/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.leftBarButtonItem = self.editButtonItem //system edit button in the navigation bar for editing the table view
    }

    // MARK: - Table view data source
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
