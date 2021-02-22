//
//  ApiHelper.swift
//  VaktiHazar
//
//  Created by HBO on 15.02.2021.
//  Copyright © 2021 Yeni Kullanıcı. All rights reserved.
//

import Foundation
import UIKit

class ApiHelper {
    
    static func login(email : String, password : String) -> [Bool: String] {
        //Send to Api
        
        var isSuccess : Bool = false
        var resultMessage : String = ""
        
        let url = URL(string: "http://biga.vaktihazar.com/User/GetUser?email=" + email+"&password=" + password)
        guard let downloadURL = url else { return [isSuccess : resultMessage]}
        URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else {
                print("something is wrong")
                resultMessage = "Giriş işlemi başarısız."
                return  }
            print("downloaded")
            isSuccess = true
            
            }.resume()
        return [isSuccess : resultMessage]
    }
    
}
