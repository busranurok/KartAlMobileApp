//
//  DeActivateUser.swift
//  VaktiHazar
//
//  Created by HBO on 21.02.2021.
//  Copyright © 2021 Yeni Kullanıcı. All rights reserved.
//

import Foundation

class DeActivateUserResponseMesssage : Codable {
    
    let IsSuccess : Bool
    let Message : String
    
    init(isSuccess : Bool, message : String) {
        
        self.IsSuccess = isSuccess
        self.Message = message
        
    }
    
}
