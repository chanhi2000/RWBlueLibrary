//
//  HTTPClient.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import UIKit

class HTTPClient {
    
    @discardableResult func getRequest(_ url:String) -> Any {
        return Data() as Any
    }
    
    @discardableResult func postRequest(_ url:String, body: String) -> Any {
        return Data() as Any
    }
    
    func downloadImage(_ url:String) -> UIImage? {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!), let image = UIImage(data: data) else {  return nil  }
        return image
    }
    
    
}
