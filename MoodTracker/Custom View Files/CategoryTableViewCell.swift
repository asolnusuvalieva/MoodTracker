//
//  CategoryTableViewCell.swift
//  MoodTracker
//
//  Created by Asol on 1/23/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
