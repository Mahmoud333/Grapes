//
//  Constants.swift
//  Grapes
//
//  Created by Mahmoud Hamad on 5/15/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

struct C {
    static let SHADOW_GRAY: CGFloat = 120.0/255.0 //Color For Shadow
    
    enum Identifiers: String {
        case ProductCell = "ProductCell"
    }
    
}

func startSpinner() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
}

func stopSpinner() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false

}
