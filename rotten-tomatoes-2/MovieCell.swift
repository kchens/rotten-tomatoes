//
//  MovieCell.swift
//  rotten-tomatoes-2
//
//  Created by Kevin Chen on 9/18/15.
//  Copyright © 2015 Kevin Chen. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var synopsisLabel: UILabel!
  @IBOutlet weak var posterView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}