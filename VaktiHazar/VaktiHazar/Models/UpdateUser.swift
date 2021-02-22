//
//  UpdateUser.swift
//  VaktiHazar
//
//  Created by HBO on 21.02.2021.
//  Copyright © 2021 Yeni Kullanıcı. All rights reserved.
//

import Foundation
class UpdateUserResponseMesssage : Codable {
    
    let IsSuccess : Bool
    let Message : String
    
    init(isSuccess : Bool, message : String) {
        
        self.IsSuccess = isSuccess
        self.Message = message
        
    }
    
}


class UpdateUserRequestMessage : Codable {
    //let ile tanımladıklarım veritabanında yazan şekli ile alınır.
    let UserId : Int?
    let Name : String?
    let Lastname : String?
    let PhoneNumber : String?
    
    init(userId : Int?, name : String?, lastName : String?, phoneNumber : String?) {
        
        self.UserId = userId
        self.Name = name
        self.Lastname = lastName
        self.PhoneNumber = phoneNumber
        
    }
    
}
