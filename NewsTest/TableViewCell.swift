//
//  TableViewCell.swift
//  NewsTest
//
//  Created by lixun on 2016/10/16.
//  Copyright © 2016年 sunshine. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var dogImage: UIImageView!
    
    var model: NewsModel{
        
        get{
            return self.model
        }
        set{
            self.content.text = newValue.info
        }
    }
    
    
    public func updateImageHeight(){
        if content.numberOfLines == 1 {
            dogImage.isHidden = true
        }else{
            dogImage.isHidden = false
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
