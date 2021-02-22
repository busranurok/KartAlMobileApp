//
//  ChangeEmail.swift
//  VaktiHazar
//
//  Created by HBO on 21.02.2021.
//  Copyright © 2021 Yeni Kullanıcı. All rights reserved.
//

import Foundation

//birden fazla veri gönderdiğimizde model oluştururuz. Hem Request hem de Response model. (Mesal aşağıdaki örnekte hem yeni şifre hem de yeni şifrenin tekrarı diye iki ayrı veri bulunur.)
//Tek veri yolluyor isem sadece Response model oluştururuz. Request i query string ile link üzerinden yollarız.

class ChangeEmailResponseMessage : Codable {
    
    let IsSuccess : Bool
    let Message : String
    
    init(isSuccess : Bool, Message : String) {
        
        self.IsSuccess = isSuccess
        self.Message = Message
        
    }
    
}


class ChangeEmailRequestMessage : Codable {
    //let ile tanımladıklarım veritabanında yazan şekli ile alınır.
    let OldEmail : String?
    let NewEmail : String?
    
    init(oldEmail : String?, newEmail : String?) {
        
        self.OldEmail = oldEmail
        self.NewEmail = newEmail
        
    }
    
}
