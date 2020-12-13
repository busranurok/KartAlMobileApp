//
//  SignInViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 26.11.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    let kConstantObj = kConstant()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dontForgerMeSwitch: UISwitch!
    @IBOutlet weak var dontForgetMeLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var signUpNowButton: UIButton!
    
    let button = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.rightViewMode = .unlessEditing
        
        button.setImage(UIImage(named: "password"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
        button.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 5), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        button.addTarget(self, action: #selector(buttonnPasswordVisbilityTapped), for: .touchUpInside)
        passwordTextField.rightView = button
        
        dontForgerMeSwitch.isOn = false
        
        setUpElements()
        
        let rememberEmail = UserDefaults.standard.string(forKey: "Email")
        let rememberPassword = UserDefaults.standard.string(forKey: "Password")
        
        if rememberEmail != nil && rememberPassword != nil {
            
            emailTextField.text=rememberEmail!
            passwordTextField.text=rememberPassword!
            //dontForgerMeSwitch.isOn = true
            //activity
            dontForgerMeSwitch.isEnabled = false
            //invisibility
            //dontForgerMeSwitch.isHidden = true
        }
        
        passwordTextField.rightViewMode = .always
        
        if passwordTextField.text != nil {
            
            passwordTextField.isSecureTextEntry = true
            button.setImage(UIImage(named: "password"), for: .normal)
            
        }

    }
    
    func setUpElements(){
        
        //Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signInButton)
        Utilities.styleHollowButton(forgetPasswordButton)
        
    }
    
    
    @IBAction func buttonnPasswordVisbilityTapped(){
        
        if self.passwordTextField.isSecureTextEntry == true {
            
            self.passwordTextField.isSecureTextEntry = false
            button.setImage(UIImage(named: "passwordEye"), for: .normal)
            
        }else {
            //closed eye
            self.passwordTextField.isSecureTextEntry = true
            button.setImage(UIImage(named: "password"), for: .normal)
            
        }
        
    }
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Lütfen, bütün boşlukları doldurun!"
            
        }
        
        //Check if the password is secure
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Check for email
        if (emailTextField.text?.isValidEmail() == false) || Utilities.isPasswordValid(cleanPassword) == false
        {
            return "Lütfen, e-postanızı ya da şifrenizi kontrol edin."
        }
        
        
        //return "Hata yok!"
        return nil
        
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        //Validate the fields
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showError(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //Send to Api
            let url = URL(string: "http://biga.vaktihazar.com/User/GetUser?email=" + email!+"&password=" + password!)
            guard let downloadURL = url else { return }
            URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
                guard let data = data, error == nil, URLResponse != nil else {
                    print("something is wrong")
                    return }
                print("downloaded")
                
                }.resume()
            
            if dontForgerMeSwitch.isOn == true {
                
                let defaults=UserDefaults.standard
                defaults.set(email!, forKey: "Email")
                defaults.set(password!, forKey: "Password")
                
            }
            
            self.transitionToHome()
            
        }
        
    }
    
    
    func transitionToHome(){
        
        let mainVcIntial = kConstantObj.SetIntialMainViewController("MyAccountVC")
        view.window?.rootViewController = mainVcIntial
        
        /*let myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController = myAccountViewController*/
        view.window?.makeKeyAndVisible()
        
    }
    
    
    
    func showError(message : String){
        
        let alert = UIAlertController(title: "Dikkat", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
        
    }
        
    }

