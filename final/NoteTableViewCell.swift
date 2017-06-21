//
//  NoteTableViewCell.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    

    
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var noteImage: UIImageView!
   

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
