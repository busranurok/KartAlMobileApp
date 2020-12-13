//
//  Utilities.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 27.11.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textField : UITextField){
        
        //Creat the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        
        //Remove border on text field
        textField.borderStyle = .none
        
        //Add the line to the text field
        textField.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button : UIButton){
        
        //Filled rounded corner style
        button.backgroundColor = UIColor.init(red:  48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        
    }
    
    static func styleHollowButton(_ button : UIButton) {
        
        //Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        //Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,10}")
        return passwordTest.evaluate(with: password)
        
    }
    
    
}
