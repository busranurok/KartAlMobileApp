//
//  ChangePassword.swift
//  VaktiHazar
//
//  Created by HBO on 21.02.2021.
//  Copyright © 2021 Yeni Kullanıcı. All rights reserved.
//

import Foundation

class ChangePasswordResponseMessage : Codable {
    
    let IsSuccess : Bool
    let Message : String
    
    init(isSuccess : Bool, Message : String) {
        
        self.IsSuccess = isSuccess
        self.Message = Message
        
    }
    
}


class ChangePasswordRequestMessage : Codable {
    //let ile tanımladıklarım veritabanında yazan şekli ile alınır.
    let UserId : Int?
    let OldPassword : String?
    let NewPassword : String?
    
    init(oldPassword : String?, newPassword : String?, userId : Int?) {
        
        self.OldPassword = oldPassword
        self.NewPassword = newPassword
        self.UserId = userId
        
    }
    
}
