//
//  ForgetPasswordViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 1.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()


    }
    
    func setUpElements(){
        
        //Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleFilledButton(sendButton)
        
    }
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Lütfen, e-posta adresinizi giriniz!"
            
        }
        
        //Check for email
        if (emailTextField.text?.isValidEmail() == false)
        {
            return "E-posta adresinizi doğru formatta girmediniz. (Örnek formatlar: vaktihazar@outlook.com , vaktihazar@gmail.com , vaktihazar@yahoo.com , vaktihazar@msn.com , vaktihazar@windowslive.com , vaktihazar@live.com )."
        }
        
        
        //return "Hata yok!"
        return nil
        
    }
    
    
    @IBAction func sendTapped(_ sender: Any) {
        
        //Validate the fields
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showError(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //Send to Api
                let url = URL(string: "http://biga.vaktihazar.com/User/ForgotPassword?email=" + email!)
                guard let downloadURL = url else { return }
                URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
                    guard let data = data, error == nil, URLResponse != nil else {
                        print("something is wrong")
                        return }
                    print("downloaded")
                    
                    }.resume()
            
                showError(message: "Şifre sıfırlama linki e-postanıza başarılı bir şekilde gönderilmiştir.")

        }
        
    }
    
    func transitionToSignIn(){
        
        let signInViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signInViewController) as? SignInViewController
        
        view.window?.rootViewController = signInViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    func showError(message : String){
        
        let alert = UIAlertController(title: "Dikkat", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
            self.transitionToSignIn()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
    

