//
//  CreatedUser.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 30.11.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class CreatedUserResponseMesssage : Codable {
    
    let isSuccess : Bool
    let errorMessage : String
    
    init(isSuccess : Bool, errorMessage : String) {
        
        self.isSuccess = isSuccess
        self.errorMessage = errorMessage
        
    }
    
}


class CreatedUserRequestMessage : Codable {
    //let ile tanımladıklarım veritabanında yazan şekli ile alınır.
    let name : String?
    let lastName : String?
    let email : String?
    let birthDate : String?
    let password : String?
    let phoneNumber : String?
    
    init(name : String?, lastName : String?, email : String?, birthDate : String?, password : String?, phoneNumber : String?) {
        
        self.name = name
        self.lastName = lastName
        self.email = email
        self.birthDate = birthDate
        self.password = password
        self.phoneNumber = phoneNumber
        
    }
    
}
