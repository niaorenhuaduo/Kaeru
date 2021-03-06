//
//  CollectionViewCell.swift
//  PeraPeraView
//
//  Created by kingkong999yhirose on 2016/07/28.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import UIKit

class LayoutAttributes: UICollectionViewLayoutAttributes {
    var progress: CGFloat = 0
    var isLast: Bool = false
    
    override func copy(with zone: NSZone?) -> Any {
        guard let attributes = super.copy(with: zone) as? LayoutAttributes else {
            fatalError()
        }
        attributes.progress = progress
        attributes.isLast = isLast
        return attributes
    }
}

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    static func nib() -> UINib {
        return UINib(nibName: className, bundle: Bundle(for: CollectionViewCell.self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = false
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4.0
        
        configureSnapShotLayer()
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        imageView.isHidden = false
        blurView.alpha = 0
    }
    
    func setup(with image: UIImage) {
        imageView.image = image
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attributes = layoutAttributes as? LayoutAttributes else {
            return
        }
        
        if attributes.isLast {
            blurView.alpha = 0
            return
        }
        
        blurView.alpha = attributes.progress < -1.2 ? fabs(pow(attributes.progress, 2)) * 0.3 : 0
    }
}
