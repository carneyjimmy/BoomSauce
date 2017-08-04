//
//  EventCell.swift
//  LuckyDuck
//
//  Created by Jimmy Carney on 6/13/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    var name: String = ""
    var cost: String = ""
    
    @IBOutlet weak var banner: UILabel!
   
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var picture: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    

}
