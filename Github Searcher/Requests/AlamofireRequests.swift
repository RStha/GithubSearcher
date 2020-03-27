//
//  AlamofireRequests.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequests {
    var className = "AlamofireRequests"
    static let sharedInstance = AlamofireRequests()
    
    func GETRequest<T: Codable>(url : String, completion : @escaping(
        _ succeded:Bool,
        _ response : T?,
        _ error: String?) -> Void){
        
        Alamofire.request(URL(string: url)!, method: .get)
            .responseJSON { (response) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil {
                        if let data = response.data{
                            
                            let mappedResponse = try! CodableHelper.decoder.decode(T.self, from: data)
                            completion(true,mappedResponse,nil)
                        }
                    }
                    break
                case .failure(_):
                    let err = response.result.error.debugDescription
                    completion(false, nil, err)
                    break
                }
        }
    }
}
