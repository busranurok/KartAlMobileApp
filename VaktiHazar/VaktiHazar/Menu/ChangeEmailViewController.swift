//
//  ChangeEmailViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 17.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class ChangeEmailViewController: UIViewController {
    
    @IBOutlet weak var currentEmailTextField: UITextField!
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var newEmailAgainTextField: UITextField!
    @IBOutlet weak var sendPinCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

    }
    
    func setUpElements(){
        
        //Style the elements
        Utilities.styleTextField(currentEmailTextField)
        Utilities.styleTextField(newEmailTextField)
        Utilities.styleTextField(newEmailAgainTextField)
       
        
        Utilities.styleFilledButton(sendPinCode)
        
        
    }
    
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  currentEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || newEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || newEmailAgainTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Lütfen, bütün boşlukları doldurun!"
            
        }
        
        //Check for email
        if (newEmailTextField.text?.isValidEmail() == false && newEmailTextField.text?.isValidEmail() == false )
        {
            return "E-posta adresinizi doğru formatta girmediniz. (Örnek formatlar: vaktihazar@outlook.com , vaktihazar@gmail.com , vaktihazar@yahoo.com , vaktihazar@msn.com , vaktihazar@windowslive.com , vaktihazar@live.com )."
        }
        
        //Check if the password is secure
        let cleanMail = newEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanMailAgain = newEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if cleanMail != cleanMailAgain {
            
            return "Girmiş olduğunuz e-posta adresleri birbiri ile uyuşmuyor.Lütfen kontrol edin!"
            
        }
        
        //return "Hata yok!"
        return nil
        
    }

    
    
    @IBAction func sendPinCodeTapped(_ sender: Any) {
        
        let  myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController =  myAccountViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
