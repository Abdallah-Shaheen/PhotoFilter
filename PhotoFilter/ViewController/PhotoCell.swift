//
//  PhotoCell.swift
//  PhotoFilter
//
//  Created by Abdallah Shaheen on 6/3/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UITableViewCell {
    @IBOutlet weak var thumbnil: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var albumId: UILabel!
    @IBOutlet weak var stateImage: UIImageView!
    
    func configure(thumbnilUrl: String,title: String,albumId: String, stateImage: UIImage, filterDone: Bool) {
        self.thumbnil.layer.cornerRadius = 10
        self.thumbnil.clipsToBounds = true
        let url = URL(string: thumbnilUrl)
        self.thumbnil.kf.setImage(with: url)
        self.title.text = title
        self.albumId.text = albumId
        if filterDone {
            self.stateImage.isHidden = true
        }
        else {
            self.stateImage.image = stateImage
        }
    }

}
