//
//  CategoryTableViewCell.swift
//  DemoToDoList
//
//  Created by Meenakshi Phadatare on 10/30/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
