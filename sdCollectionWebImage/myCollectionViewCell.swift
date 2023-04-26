//
//  myCollectionViewCell.swift
//  sdCollectionWebImage
//
//  Created by Mohan K on 13/02/23.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImg: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        myImg.image = UIImage(named: "empty")
    }
}
