//
//  CollectionViewCell.swift
//  Grapes
//
//  Created by Mahmoud Hamad on 5/14/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imageVHeightConstraint: NSLayoutConstraint!
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4
        
    }
    
    func ConfigureCell(product: Product, img: UIImage?){
        self.product = nil
        self.product = product
        
        /*
        if img != nil { //found it
            
            imageV.image = img
            print("SMGL: CachedImage")
            
        } else { //didn't find it
            /*
             if let img = MainVC.imageCache.object(forKey: self.product!.imgURL as NSString) { //found it
             imageV.image = img
             print("SMGL: CachedImage")
             } else { //didn't find it
             */
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { //[unowned self] in //() -> Void in
                
                do {
                    let imgURL = URL(string: self.product!.imgURL)
                    let data = try Data(contentsOf: imgURL!)
                    let img = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.imageV.image = img
                        print("SMGL: CachedImage New")
                        MainVC.imageCache.setObject(img!, forKey: "\(imgURL)" as NSString) //cache it
                    }
                    
                } catch let error as Error { print("Error with setting ImageView: \(error.localizedDescription) ") }
            }
        } */
        
        let imgURL = URL(string: self.product!.imgURL)
        startSpinner()
        self.imageV.kf.setImage(with: imgURL)
        stopSpinner()
        
        self.descLabel.text = self.product!.productDescription
        self.priceLabel.text = "\(self.product!.price)"
        print("SMGL: self.product: \(self.product)")
        print("SMGL: product: \(product)")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? ProductLayoutAttributes {
            // - change image height
            imageVHeightConstraint.constant = attributes.photoHeight
        }
    }
}

