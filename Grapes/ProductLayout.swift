//
//  ProductLayout.swift
//  Grapes
//
//  Created by Mahmoud Hamad on 5/15/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

protocol CollectionViewFeedLayoutDelegateSMGL: class {
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath:IndexPath,with width: CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with Width: CGFloat) -> CGFloat
}

class ProductLayout: UICollectionViewLayout {//, UICollectionViewLayout
    
    //var controller: MainVC? //bad coding example :''(
    var delegate: CollectionViewFeedLayoutDelegateSMGL?
    
    var numberColumns: CGFloat = 2.0
    var cellPadding: CGFloat = 5.0 //space between the items
    
    var contentHeight: CGFloat = 0.0
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset //inset of right and left of the collectionview
        return (collectionView!.bounds.width - (insets.left + insets.right))
    }
    
    static var attributeCache = [ProductLayoutAttributes]()
    
    override func prepare() { //when the layout of collectionview changed (rotate)
        //calculate x offset
        
        if ProductLayout.attributeCache.isEmpty { //calculate it again
            let columnWidth = contentWidth / numberColumns
            
            var xOffsets = [CGFloat]()          //hve more than 1 column
            for column in 0..<Int(numberColumns) { //from 0 to less than numberColumns-1, [0,1]
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffsets = [CGFloat].init(repeating: 0, count: Int(numberColumns))
            
            //if we have more than 1 section we might loop through them
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                //calculate the frame For Post
                //Before
                //let photoHeight: CGFloat = 0.0
                //let captionHeight: CGFloat = 0.0
                //After
                let width = columnWidth - cellPadding * 2 //For each cell
                
                let photoHeight: CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForPhotoAt: indexPath, with: width))! //will crash if collectionView doesn't conform to protocol
                let captionHeight: CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForCaptionAt: indexPath, with: width))!
                
                
                //width was here before
                let height = cellPadding + photoHeight + captionHeight + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                //create layout attributes
                let attributes = ProductLayoutAttributes(forCellWith: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                ProductLayout.attributeCache.append(attributes)
                
                // update column, yOffset
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                
                
                if column >= (Int(numberColumns) - 1) { //if its 1st column jump to 2nd and if its 2nd jump to 1st
                    column = 0
                } else {
                    column += 1
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //if the things in cell intersects with the cell attributes
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in ProductLayout.attributeCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}


class ProductLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ProductLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let attributes = object as? ProductLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}
























