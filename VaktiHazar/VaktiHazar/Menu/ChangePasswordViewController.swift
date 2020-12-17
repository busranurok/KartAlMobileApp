//
//  ChangePasswordViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 17.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var againNewPasswordTextField: UITextField!
    
    @IBOutlet weak var saveChangesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    
    }
    
    
    func setUpElements(){
        
        //Style the elements
        Utilities.styleTextField(currentPasswordTextField)
        Utilities.styleTextField(newPasswordTextField)
        Utilities.styleTextField(againNewPasswordTextField)
        
        
        Utilities.styleFilledButton(saveChangesButton)
        
        
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        againNewPasswordTextField.delegate = self
        
        
        hideKeyboardTappedAround()
        
        
    }
    
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  currentPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || againNewPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Lütfen, bütün boşlukları doldurun!"
            
        }
        
        
        //Check if the password is secure
        let cleanPassword = newPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword2 = againNewPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false && Utilities.isPasswordValid(cleanPassword2) == false {
            
            //Password isn' t secure enough
            return "Lütfen şifrenizin en az 8 en fazla 10 karakterden en az 1 Büyük Harfli Alfabe, 1 Küçük Harfli Alfabe, 1 Rakam ve 1 Özel Karakter olduğundan emin olun."
            
        }
        
        if cleanPassword != cleanPassword2 {
            
            return "Girmiş olduğunuz şifreler birbiri ile uyuşmuyor.Lütfen kontrol edin!"
            
        }
        
        //return "Hata yok!"
        return nil
        
    }
    
    
    @IBAction func saveChangesButtonTapped(_ sender: Any) {
        
        let  myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController =  myAccountViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        let  myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController =  myAccountViewController
        view.window?.makeKeyAndVisible()
        
    }
    

}
