//
//  LatestTableViewCell.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import UIKit

class LatestTableViewCell: UITableViewCell {

    @IBOutlet weak var teamHomeImage: UIImageView!
    @IBOutlet weak var teamHomeLbl: UILabel!
    @IBOutlet weak var teamawayImage: UIImageView!
    @IBOutlet weak var teamAwayLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
