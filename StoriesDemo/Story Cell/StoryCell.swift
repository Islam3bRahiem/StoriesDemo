//
//  StoryCell.swift
//  MoonUser
//
//  Created by Grand iMac on 1/26/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import UIKit
import SDWebImage

class StoryCell: UICollectionViewCell {

    @IBOutlet weak fileprivate var userImg: UIImageView!
    @IBOutlet weak fileprivate var userNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: String?, name: String?) {
        let imgURL = URL(string: image ?? "")
        userImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImg.sd_setImage(with: imgURL)
        userNameLbl.text = name
    }


}
