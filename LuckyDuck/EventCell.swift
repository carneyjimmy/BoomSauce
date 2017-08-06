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
        /* black overlay  */
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.picture.frame.size.width + 100, height:  self.picture.frame.size.height + 100))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15)
        self.picture.addSubview(overlay)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    

}
