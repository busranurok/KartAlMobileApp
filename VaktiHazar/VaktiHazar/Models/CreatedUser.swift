//
//  CreatedUser.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 30.11.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class CreatedUserResponseMesssage : Codable {
    
    let IsSuccess : Bool
    let ErrorMessage : String
    
    init(isSuccess : Bool, errorMessage : String) {
        
        self.IsSuccess = isSuccess
        self.ErrorMessage = errorMessage
        
    }
    
}


class CreatedUserRequestMessage : Codable {
    //let ile tanımladıklarım veritabanında yazan şekli ile alınır.
    let Name : String?
    let Lastname : String?
    let Email : String?
    let Birthdate : String?
    let Password : String?
    let PhoneNumber : String?
    
    init(name : String?, lastName : String?, email : String?, birthdate : String?, password : String?, phoneNumber : String?) {
        
        self.Name = name
        self.Lastname = lastName 
        self.Email = email
        self.Birthdate = birthdate
        self.Password = password
        self.PhoneNumber = phoneNumber
        
    }
    
}
