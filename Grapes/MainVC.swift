//
//  ViewController.swift
//  Grapes
//
//  Created by Mahmoud Hamad on 5/14/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewFeedLayoutDelegateSMGL {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productss = [Product]()
    
    //static var imageCache: NSCache <NSString, UIImage> = NSCache()
    //static bec. we gonna use it in multiple locations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? ProductLayout {
            layout.delegate = self
        }
        fetchNew = true
        fetchSomeProduct()
    }
    
    
    //var fetchNew = false
    func fetchSomeProduct(){
       //if fetchNew == true {
            fetchNew = false
            let url = "http://grapesnberries.getsandbox.com/products?count=12&from=car"
            
            print("SMGL: productsCount was = \(productss.count)")
            startSpinner()
            Alamofire.request(url).responseJSON { (response) in
                let result = response.result
                print(result)
                print(result.value)
                
                if let dictArray = result.value as? [Dictionary<String, Any>] {
                    print("SMGL:dictArray \(dictArray) ")
                    
                    for productDict in dictArray {
                        
                        let prd = Product(ProductSmallDict: productDict)
                        print("SMGL: prd: \(prd)")
                        self.productss.append(prd)
                    }
                    ProductLayout.attributeCache.removeAll()
                    self.collectionView.reloadInputViews()
                    self.collectionView.reloadData()
                    print("SMGL: productsCount became = \(self.productss.count)")
                    
                }
            }
       //}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == productss.count - 2 {
            //fetchNew = true
            fetchSomeProduct()
        }
        
        print("productsCount cellForRow \(collectionView.numberOfItems(inSection: 0))")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.Identifiers.ProductCell.rawValue, for: indexPath) as? CollectionViewCell {
            
            let product = productss[indexPath.item]
            /*
             if let img = MainVC.imageCache.object(forKey: product.imgURL as NSString ) { //found it
             
             cell.ConfigureCell(product: product,img: img)
             
             } else {  }*/
            //cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            
            cell.ConfigureCell(product: product,img: nil)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximum = scrollView.contentSize.height - scrollView.frame.size.height
        
        print("SMGL:scrollViewDidEndDragging \(maximum - currentOffset)")
        
        if maximum - currentOffset <= 10.0 {

        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("productsCount Section")
        return productss.count
    }
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var labelText = productss[indexPath.row].productDescription
        
        if labelText.characters.count > 0 && labelText.characters.count < 30 {
            return CGSize(width: 150, height: productss[indexPath.row].imageHeight + 40)
            
        } else {
            return CGSize(width: 150, height: productss[indexPath.row].imageHeight + 60)
        }
    }
    */
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat { /*
        if let product = productss[indexPath.item], let photo = product.image {
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRation: photo.size, insideRect: boundingRect)
            
            return rect.size.height
        }*/
        return CGFloat(productss[indexPath.item].imageHeight)
    }
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with Width: CGFloat) -> CGFloat {
        
        let product = productss[indexPath.item]
        let topPadding = CGFloat(8)     //between "the text" and the image
        let bottomPadding = CGFloat(12)
        let captionFont = UIFont.systemFont(ofSize: 15)
        let captionHeight = self.height(forText: product.productDescription, withFont: captionFont, width: Width)
        //other things height
        let height = topPadding + captionHeight + bottomPadding // + topPadding + anotherThingHeight
        collectionView.reloadData()
        
        return height
    }
    
    func height(forText text: String, withFont font: UIFont,width: CGFloat) -> CGFloat {
        let nsstring = NSString(string: text)
        let maxHeight = CGFloat(80.0) //the max Height was 64.0
        let textAttributes = [NSFontAttributeName:font] //italic, bold, underlined, colors, links,colors around the font, or that little border of the font so they have alot of neat things u can do
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        
        return ceil(boundingRect.height)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}






















