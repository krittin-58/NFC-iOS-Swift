//
//  ProductModel.swift
//  CoreNFCSample
//
//  Created by Krittin Jaruvisut on 8/12/2561 BE.
//  Copyright © 2561 Dobrinka Tabakova. All rights reserved.
//

import Foundation
import UIKit

class ProductModel: NSObject {
    //propertites
    /*
     [
     {
     "productPrice" : "12",
     "productBrand" : "t1",
     "productColor" : "t3",
     "productCategory" : " t2",
     "productName" : "ผ้า",
     "productId" : "17"
     }
     ]
     */
    var productId: String?
    var productName: String?
    var productBrand: String?
    var productCategory: String?
    var productColor: String?
    var productPrice: String?
    
    override init() {
        //
    }
    
    init(productId: String?, productName: String?, productBrand: String?, productCategory: String?, productColor: String?, productPrice: String?) {
        self.productId = productId
        self.productName = productName
        self.productBrand = productBrand
        self.productCategory = productCategory
        self.productColor = productColor
        self.productPrice = productPrice
    }
    
}
