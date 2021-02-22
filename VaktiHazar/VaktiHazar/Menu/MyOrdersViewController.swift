//
//  MyOrdersViewController.swift
//  VaktiHazar
//
//  Created by HBO on 15.02.2021.
//  Copyright © 2021 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var datePickerView: UIPickerView!
    
    let source = ["2021", "2022", "2023", "2024", "2025", "2026"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePickerView.delegate = self
        datePickerView.dataSource = self
        
        //İlk başta Label elementimiz bir değer almadığı için “Main.storyboard” sayfasında yazdığımız şekliyle kalıyor. Bunun olmaması için, “viewDidLoad” fonksiyonumuzda Label elementimize dizimizin sıfırıncı değerini verilir.
        label.text = source[0]
        
        //Kaç tane PickerView kullanacağımızı belirtiriz.
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
            }
        
        //PickerView elementimizin içinde kaç tane bileşen olacağını belirtiriz.
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                return source.count
            }
        
        //Dizimizde yazılan değerler çıkmıyor.Bu sorunu çözmek için ekstra bir fonksiyon daha kullanacağız: “titleForRow”.
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
             return source[row]
            
        }
        
        //PickerView elementimizde seçili olan değeri Label elementine yazdırmak için ekstra bir fonksiyon daha kullanacağız: “didSelectRow”.
        //Hangi element seçili ise onun değerini label e yazdırırız.
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            label.text = source[row]
            
        }
        
    }

}
