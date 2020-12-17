//
//  PersonelInformationViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 13.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class PersonelInformationViewController: UIViewController, UITextFieldDelegate {
    
    var phoneNumber = String()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var law6563Switch: UISwitch!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var passiveMembershipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Making switch button unselected at first
        law6563Switch.isOn = false
        
        
        //Phone number style
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .phonePad
        
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        
        
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
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(phoneTextField)
        Utilities.styleFilledButton(saveChangesButton)
        Utilities.styleHollowButton(passiveMembershipButton)
        
        
    }
    
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Lütfen, bütün boşlukları doldurun!"
            
        }
        
        if law6563Switch.isOn == false {
            
            return "Lütfen 6563 sayılı kanun kapsamında KartAl' dan ticari elektronik ileti almayı onaylayınız."
            
        }
        
        
        //return "Hata yok!"
        return nil
        
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
        //Validate the fields
       /* var errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showError(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let name = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Send to Api
            let url = URL(string: "http://biga.vaktihazar.com/User/CreateUser")
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
            let requestBody = CreatedUserRequestMessage(name: name, lastName: lastName, phoneNumber: phoneNumber)
            
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
                    let response = try! JSONDecoder().decode(CreatedUserResponseMesssage.self, from: jsonData)
                    
                    
                    var resultStr : String = ""
                    resultStr += "Is Success: \(response.isSuccess) ErrorMessage : \(response.errorMessage) \n"
                    
                    
                    if(!response.isSuccess)
                    {
                        errorMessage = "Kullanıcı oluşturulurken hata oluştu : \(response.errorMessage)"
                    }
                    
                    let alert = UIAlertController(title: "Information", message: resultStr, preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } catch let jsonErr{
                    
                    print(jsonErr)
                    
                }
                
            }
            task.resume()
            
            
            //Create the user
            if errorMessage != nil{
                
                //There was an error creating the user
                showError(message: errorMessage!)
                
            }
            else{
                
                //Transition to the home screen
                transitionToHome()
                
            }
            
            
        }
        
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func showError(message : String){
        
        let alert = UIAlertController(title: "Dikkat", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}*/

 }
    
}

