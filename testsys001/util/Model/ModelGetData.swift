//
//  ModelGetData.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

import UIKit
import ObjectMapper


class ModelGetData: Mappable {
    var results:[ModelData] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        results     <- map["data"]
    }
}

