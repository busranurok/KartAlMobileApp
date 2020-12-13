//
//  SignUpViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 26.11.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var phoneNumber = String()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthDateTextfield: UITextField!
    @IBOutlet weak var againPasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var kvkkApprovalSwitch: UISwitch!
    @IBOutlet weak var lawApprovalSwitch: UISwitch!
    @IBOutlet weak var goOnButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var approvalKVKKLabel: UILabel!
    @IBOutlet weak var approval6563LawLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Making switch buttons unselected at first
        kvkkApprovalSwitch.isOn = false
        lawApprovalSwitch.isOn = false
        
        
        //Phone number style
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .phonePad
        
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        againPasswordTextField.delegate = self
        birthDateTextfield.delegate = self
        
        
        
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
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(birthDateTextfield)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(againPasswordTextField)
        Utilities.styleTextField(phoneTextField)
        
        Utilities.styleFilledButton(goOnButton)

        
    }
    
    //Check the fields and validation that the data is correct. If everthing is correct, this method return nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || againPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || birthDateTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Lütfen, bütün boşlukları doldurun!"
            
        }
        
        //Check for email
        if (emailTextField.text?.isValidEmail() == false)
        {
            return "E-posta adresinizi doğru formatta girmediniz. (Örnek formatlar: vaktihazar@outlook.com , vaktihazar@gmail.com , vaktihazar@yahoo.com , vaktihazar@msn.com , vaktihazar@windowslive.com , vaktihazar@live.com )."
        }
        
        //Check if the password is secure
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword2 = againPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false && Utilities.isPasswordValid(cleanPassword2) == false {
            
            //Password isn' t secure enough
            return "Lütfen şifrenizin en az 8 en fazla 10 karakterden en az 1 Büyük Harfli Alfabe, 1 Küçük Harfli Alfabe, 1 Rakam ve 1 Özel Karakter olduğundan emin olun."
            
        }
        
        if cleanPassword != cleanPassword2 {
            
            return "Girmiş olduğunuz şifreler birbiri ile uyuşmuyor.Lütfen kontrol edin!"
            
        }
        
        if kvkkApprovalSwitch.isOn == false || lawApprovalSwitch.isOn == false {
            
            return "Lütfen Üyelik koşulları, Kişisel Verilerin Korunması ve İşlenmesi Aydınlatma Metni ve Kişisel Verilerin Korunması ve İşlenmesi Açık Rıza Metni onayını ile birlikte 6563 sayılı kanun kapsamında KartAl' dan ticari elektronik ileti almayı onaylayınız."
            
        }
        
        
        //return "Hata yok!"
        return nil
        
    }
    
    @IBAction func goOnTapped(_ sender: Any) {
        
        //Validate the fields
        var errorMessage = validateFields()
        
        if errorMessage != nil {
            
            //There is something wrong with the fields, show error message
            showError(message: errorMessage!)
            
        } else {
            
            //Created cleaned the version of the data
            let name = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let againPassword = againPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let birthDate = birthDateTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
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
            let requestBody = CreatedUserRequestMessage(name: name, lastName: lastName, email:email, birthDate: "2020-12-01T00:22:34.0748456+03:00", password: password , phoneNumber: phoneNumber)
            
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
    
}


//Validation Extension for phone Number Check
extension UITextFieldDelegate {
    
    // mask example: `+XX (XXX) XXX-XXXX`
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
}


//Validation Extension for email check
extension String {
    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^(((([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])+(\\.([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])|(\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-zA-Z]|\\d|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])|(([a-zA-Z]|\\d|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])([a-zA-Z]|\\d|-|\\.|_|~|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])*([a-zA-Z]|\\d|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])))\\.)+(([a-zA-Z]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])|(([a-zA-Z]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])([a-zA-Z]|\\d|-|_|~|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])*([a-zA-Z]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])))\\.?$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    func isValidName() -> Bool{
        let regex = try? NSRegularExpression(pattern: "^[\\p{L}\\.]{2,30}(?: [\\p{L}\\.]{2,30}){0,2}$", options: .caseInsensitive)
        
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    } }



extension UIViewController {
    
    func hideKeyboardTappedAround() {
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
}
