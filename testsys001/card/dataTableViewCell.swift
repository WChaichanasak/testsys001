//
//  dataTableViewCell.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

import UIKit

class dataTableViewCell: UITableViewCell {

    @IBOutlet weak var labelFund: UILabel!
    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var labelUpdate: UILabel!
    @IBOutlet weak var labelPerformance: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addBorder(in: v2)
        addBorder(in: v3)
        addBorder(in: v4)
        addBorder(in: v5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
