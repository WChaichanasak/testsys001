1. ใช้เวลาทำไป 3 ชั่วโมง 30 นาที ถ้า ได้เวลาเพิ่มอาจจะทำ Auto layout กับ ทำ Result ให้ดี


2. feature หลักๆ มีใช้ Alamofire ผสม objectmapper ในการดึงข้อมูลจาก JSON

```AF.request(requestURL, method:httpMethod, parameters:postDataReplace).responseString { response in
                
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
            }```




    ใช้ objectmapper


    
```
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
```

3. เรื่อง Performance ยังไม่เคยมีประสบการณ์ เลย ครับส่วนใหญ่ เป็นการติดตามผ่าน ลูกค้า

4. อาจจะปรับ ส่วนของ Parameters ในการ Mapping api ให้ง่ายยิ่งขึ้น