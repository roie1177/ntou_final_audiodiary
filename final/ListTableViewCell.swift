//
//  ListTableViewCell.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var songurl: UILabel!
    
    
    @IBAction func play(_ sender: Any) {
        
        let search = songurl.text!
        UIApplication.shared.open(URL(string:search)!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
