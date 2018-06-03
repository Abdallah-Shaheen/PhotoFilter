//
//  Service.swift
//  PhotoFilter
//
//  Created by Abdallah Shaheen on 6/3/18.
//  Copyright © 2018 Me. All rights reserved.
//

import Foundation
import UIKit

class Service {
    
    class var sharedInstance : Service {
        struct Singleton {
            static let instance = Service()
        }
        return Singleton.instance
    }
    
    //MARK:- fetch json data
    func fetchData(url: String, success:@escaping (Data)->Void, fail: @escaping (Error) -> Void){
        let url = URL(string: url)!
        let request = NSMutableURLRequest(url:url)
        
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                fail(error!)
                return
            }
            success(data!)
        }
        
        task.resume()
    }
}
