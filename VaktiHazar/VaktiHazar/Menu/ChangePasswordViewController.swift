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
        
        /*let  myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController =  myAccountViewController
        view.window?.makeKeyAndVisible()*/
        
        //Validate the fields
        var errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showAlert(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let userId = Constants.GlobalSettings.userId
            let oldPassword = currentPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let newPassword = newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
           
            
            //Send to Api
            //burada model gönderiyoruz.
            let url = URL(string: "http://biga.vaktihazar.com/User/ChangePassword")
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
            let requestBody = ChangePasswordRequestMessage(oldPassword: oldPassword, newPassword: newPassword, userId: userId)
            
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        let  myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
        
        view.window?.rootViewController =  myAccountViewController
        view.window?.makeKeyAndVisible()
        
    }
        
}
    
