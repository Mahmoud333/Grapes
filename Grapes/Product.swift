//
//  Product.swift
//  Grapes
//
//  Created by Mahmoud Hamad on 5/14/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation

class Product {
    
    private var _productDescription: String!
    private var _price: Float!
    
    private var _imgURL: String!
    private var _imageHeight: Double!
    private var _imageWidth: Double!
    
    init(ProductSmallDict: Dictionary<String, Any>) {
        print("ProductSmallDict__ \(ProductSmallDict)")
        
        if let productDescription = ProductSmallDict["productDescription"] as? String {
            self._productDescription = productDescription
        }
        
        if let price = ProductSmallDict["price"] as? Float {
            self._price = price
        }
        
        if let image = ProductSmallDict["image"] as? [String: Any] {
            
            if let imgHeight = image["height"] as? Double {
                self._imageHeight = imgHeight
            }
            
            if let imgWidth = image["width"] as? Double {
                self._imageWidth = imgWidth
            }
            
            if let imgurl = image["url"] as? String {
                self._imgURL = imgurl
            }
        }
    }
    
    var productDescription: String {
        get{
            if _productDescription == nil { return "" }
            return _productDescription
        }
    }
    var price: Float {
        get{
            if _price == nil { return 0.0 }
            return _price
        }
    }
    var imgURL: String {
        get{
            if _imgURL == nil { return "" }
            return _imgURL
        }
    }
    var imageHeight: Double {
        get{
            if _imageHeight == nil { return 0.0 }
            return _imageHeight
        }
    }
    var imageWidtht: Double {
        get{
            if _imageWidth == nil { return 0.0 }
            return _imageWidth
        }
    }
    
    
}
