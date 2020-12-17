//
//  ChangeAddressViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 17.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class ChangeAddressViewController: UIViewController, UITextFieldDelegate {

    var phoneNumber = String()
    
    @IBOutlet weak var addressTitleTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Phone number style
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .phonePad
        
        
        addressTitleTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        addressTextField.delegate = self
        postCodeTextField.delegate = self
        
        hideKeyboardTappedAround()
        
        
        setUpElements()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
        
    }
    
    
    //Phone number style
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.phoneTextField) && textField.text == ""{
            textField.text = "+90(5" //your country code default
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.phoneTextField){
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "+XX (XXX) XXX-XXXX", phone: newString)
            return false
            
        }
        return true
        
    }
    
    
    func setUpElements(){
        
        //Style the elements
        Utilities.styleTextField(addressTitleTextField)
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(phoneTextField)
        Utilities.styleTextField(addressTextField)
        Utilities.styleTextField(postCodeTextField)
       
        
        Utilities.styleFilledButton(saveChangesButton)
        
        
    }
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || postCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || addressTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Lütfen, bütün boşlukları doldurun!"
            
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
