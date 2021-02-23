//
//  NoteTableViewCell.swift
//  MoodTracker
//
//  Created by Asol on 2/23/21.
//  Copyright © 2021 Asol. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textExtract: UILabel!
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
