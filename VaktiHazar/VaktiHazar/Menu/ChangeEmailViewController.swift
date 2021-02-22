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
        
        let email = Constants.GlobalSettings.email
        currentEmailTextField.text = email
        
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
        let cleanMailAgain = newEmailAgainTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Check for email
        if (cleanMail.isValidEmail() == false || cleanMailAgain.isValidEmail() == false)
        {
            return "E-posta adresinizi doğru formatta girmediniz. (Örnek formatlar: vaktihazar@outlook.com , vaktihazar@gmail.com , vaktihazar@yahoo.com , vaktihazar@msn.com , vaktihazar@windowslive.com , vaktihazar@live.com )."
        }
        
        if cleanMail != cleanMailAgain {
            
            return "Girmiş olduğunuz e-posta adresleri birbiri ile uyuşmuyor.Lütfen kontrol edin!"
            
        }
        
        //return "Hata yok!"
        return nil
        
    }

    
    
    @IBAction func changeEmailTapped(_ sender: Any) {
        
        //Validate the fields
        var errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showAlert(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let oldEmail = currentEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let newEmail = newEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
           
            
            //Send to Api
            //burada model gönderiyoruz.
            let url = URL(string: "http://biga.vaktihazar.com/User/ChangeEmail")
            guard let requestUrl = url else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            
            // Set HTTP Request Header (Varlığında ne göndereceğim)
            //token burada gönderilir
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //textlerden bilgiler alınıyor: productNameText.text şeklinde
            //body e yazılacak kısım
            //We get the ones defined with let in the createduser model folder.
            let requestBody = ChangeEmailRequestMessage (oldEmail: oldEmail, newEmail: newEmail)
            
            var jsonData = try! JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
            
            
                
               let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    if let error = error {
                        
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        
                        //butona tıklanınca bir şey olmasın istediğimiz için handler a ihtiyacımız yok
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    
                    guard let data = data else {return}
                    
                    do{
                        
                        //datayı önce string e çeviriyorum
                        //bir formata çevirmiş isem o formata encode ettim olur
                        //orjinal formatına çevirir isem decode ederim
                        let dataString = String(data: data, encoding: .utf8)
                        //sonra onu json a çeviriyorum
                        jsonData = dataString!.data(using: .utf8)!
                        //json dan nesneye çevirmek decode (bana dönen cevap)
                        let response = try! JSONDecoder().decode(UpdateUserResponseMesssage.self, from: jsonData)
                        
                        if response.IsSuccess == false {
                            
                            self.showAlert(message: response.Message)
                            return
                        }
                        
                        
                        var resultStr : String = ""
                        resultStr += "Is Success: \(response.IsSuccess) ErrorMessage : \(response.Message) \n"
                        
                        
                        if(!response.IsSuccess)
                        {
                            errorMessage = "Değişiklikleri kaydederken bir hata oluştu : \(response.Message)"
                        }
                        else{
                            DispatchQueue.main.async {
                                self.transitionToSignIn()
                            }
                        }
                        
                    } catch let jsonErr{
                        
                        print(jsonErr)
                        
                    }
                    
                }
                task.resume()
            
            
            //Create the user
            if errorMessage != nil{
                
                //There was an error creating the user
                showAlert(message: errorMessage!)
                
            }
            else{
                
                //Transition to the home screen
                
                
            }
           
            
        }
        
    }
    
    func transitionToSignIn(){
        
        let  myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController =  myAccountViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func showAlert(message : String){
        
        let alert = UIAlertController(title: "Dikkat", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
        
    }
       
}
