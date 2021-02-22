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
        
        
        //apiye userid bilgisi gönderilerek user ın detayları alınacak
       
        
        var name:String = ""
        var surname:String = ""
        var phone:String = ""
        
        let url = URL(string: "http://biga.vaktihazar.com/User/GetUserById?id=" + String(Constants.GlobalSettings.userId))
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else {
                print("something is wrong")
                return }
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            
                            // Print out entire dictionary
                            print(convertedJsonIntoDict)
                            
                            // Get value by key
                    name = convertedJsonIntoDict["Name"] as! String
                    surname = convertedJsonIntoDict["Lastname"] as! String
                    phone = convertedJsonIntoDict["PhoneNumber"] as! String
                    
                   
                        }
             } catch let error as NSError {
                        print(error.localizedDescription)
              }
            
            
            
             
            print("downloaded")
            
            DispatchQueue.main.async {
                //alınan bilgilerle de textboxlar doldurulacak
                self.firstNameTextField.text = name
                self.lastNameTextField.text = surname
                self.phoneTextField.text = phone
            }
           
            
            }.resume()
        
        
       
        
      
        
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
        var errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showAlert(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let userId = Constants.GlobalSettings.userId
            let name = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Send to Api
            let url = URL(string: "http://biga.vaktihazar.com/User/UpdateUser")
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
            let requestBody = UpdateUserRequestMessage (userId: userId, name: name, lastName: lastname, phoneNumber: phoneNumber)
            
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
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signInViewController) as? SignInViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func showAlert(message : String){
        
        let alert = UIAlertController(title: "Dikkat", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
        
    }
        
    @IBAction func passiveMembershipTapped(_ sender: Any) {
        
        var isSuccess : Bool = false
        //controller/action/parametter(s)
        let url = URL(string: "http://biga.vaktihazar.com/User/DeactivateUser?id=" + String(Constants.GlobalSettings.userId))
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else {
                print("something is wrong")
                return }
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            
                            // Print out entire dictionary
                            print(convertedJsonIntoDict)
                            
                            // Get value by key
                            isSuccess = convertedJsonIntoDict["IsSuccess"] as! Bool
                    
                        }
             } catch let error as NSError {
                        print(error.localizedDescription)
              }
            
             
            print("downloaded")
            
            }.resume() //It is an indication that the processes in the api are finished.
        
        
        if isSuccess == false {
            showAlert(message: "Üyeliğiniz pasif edilmiştir.")
        } else {
            showAlert(message: "Üyeliğiniz pasif edilirken bir hata oluştu.")
        }
        
    }
    
}

