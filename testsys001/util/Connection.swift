//
//  Connection.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

import Foundation
import Alamofire
import ObjectMapper

class connection: NSObject {
    func requestData(httpMethod: HTTPMethod, postData : [String: String], attachImages : [UIImage]? = nil, completion : @escaping (_ status : Bool,_ message : String,_ command : String,_ resultJSON : String) -> Void) {
        
        
        var requestURL : String =  "https://storage.googleapis.com/finno-ex-re-v2-static-staging/recruitment-test/fund-ranking-1Y.json" //"http://localhost:8080/car/api.php" //http://localhost:8080/room/api.php test url
        
        
        let postCommand: String = postData["command"] ?? "";
        
        print(postData)
        
        
        var postDataReplace : [String: String] = postData;
        
        
            
            AF.request(requestURL, method:httpMethod, parameters:postDataReplace).responseString { response in
                
                if let json = response.value {
                        print(json)
                        let buildRequest: BuildRequest = Mapper<BuildRequest>().map(JSONString: json)!;
                        
                        completion(buildRequest.command == postCommand, buildRequest.status, buildRequest.command, json);
                    }
                else {
                    
                    print("error")
                    
                    completion(false, "Internal server error", "", "");
                    
                    AF.request(requestURL, method: .get, parameters: postDataReplace, headers: nil).responseString  { response in
                    if let json = response.value {
                        
                        print("JSON: \(json)") // serialized json response after post
                        
                        let buildRequest: BuildRequest = Mapper<BuildRequest>().map(JSONString: json)!;
                    }
                    }
                }
            }
        
    }
    
   
}

class BuildRequest: NSObject, Mappable {
    
    var command: String = "";
    
    var message: String  = "";
    var status :String = "";
    
    var url:String = "";
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        command <- map["command"]
        
        message <- map["message"]
        
        status <- map["status"]
        
        url <- map["export_url"]
    }
}

extension String{
    func toDictionary() -> NSDictionary {
        let blankDict : NSDictionary = [:]
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return blankDict
    }
}
