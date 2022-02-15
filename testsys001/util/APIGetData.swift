//
//  APIGetData.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

import Foundation

import UIKit

import ObjectMapper

class APIGetData: NSObject {
    
    func request(completion : @escaping (_ status : Bool,_ message : String,_ command: String,_ result: [ModelData]) -> Void){
        
        let postData : [String: String] = ["":""];
        
        connection().requestData(httpMethod: .get, postData: postData) { (status, message, command, resultJSON) in
            
            if(status) {
                let buildModelData: ModelGetData = Mapper<ModelGetData>().map(JSONString: resultJSON)!;
                
                completion(true, message, command, buildModelData.results);
            }
            else{
                completion(false, message, command,[]);
            }
        }
    }
}
