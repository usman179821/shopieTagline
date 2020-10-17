//
//  orderModel.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 20/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import Foundation
struct orderActiveModel {
    
    public private(set) var orderID: String?
    public private(set) var customerID : String?
    public private(set) var merchantID : String?
    public private(set) var driverID : String?
    public private(set) var productID : String?
    public private(set) var productName : String?
    public private(set) var ProductQuantity : Int?
    public private(set) var orderPlacedDate :String?
    public private(set) var bussinessName: String?
    public private(set) var totalcost: Double?
    public private(set) var customerName: String?
    public private(set) var merchantName: String?
    
}
struct getProductMerchantModel {
    public private(set) var productname: String?
    public private(set) var price: Int?
    public private(set) var stock: Int?
    public private(set) var imageUrl: String?
    public private(set) var ImageID: Int?
}

struct categoryModel {
    public private(set) var parentID: String?
    public private(set) var categoryID: String?
    public private(set) var name: String?
}
