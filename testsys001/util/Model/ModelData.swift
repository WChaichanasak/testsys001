//
//  ModelData.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

//mstar_id    :    F00000ZMXD
//thailand_fund_code    :    PRINCIPAL VNEQ-A
//nav_return    :    74.80117
//nav    :    14.154
//nav_date    :    2021-09-07T00:00:00.000Z
//avg_return    :    63.633823


import UIKit
import ObjectMapper


class ModelData: Mappable {
    var id:String = ""
    var thcode:String = ""
    var navRe:Double = 0.0
    var nav:Double = 0.0
    var dateNav:String = ""
    var avg:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id      <- map["mstar_id"]
        thcode  <- map["thailand_fund_code"]
        navRe   <- map["nav_return"]
        nav     <- map["nav"]
        dateNav <- map["nav_date"]
        avg     <- map["avg_return"]
    }
}


class ModelDataEmpty: NSObject {
    
    public func initialize() -> ModelData {
        
        return ModelData(map: Map(mappingType: .fromJSON, JSON: [:]))!
    }
}
