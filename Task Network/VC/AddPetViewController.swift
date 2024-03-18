//
//  AddPetViewController.swift
//  Task Network
//
//  Created by Noura Aldaihani on 05/03/2024.
//

import UIKit
import Eureka

class AddPetViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        
    }
    
    
    private func setupForm() {
        form +++ Section("Add New Pet")
        
        
        <<< TextRow() { row in
            row.title = " Pet Name"
            row.placeholder = "Enter Your Pet Name"
            row.tag = "Name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            
        }
        <<< TextRow() { row in
            row.title = " Is Pet Adopted ?"
            row.placeholder = "Enter Your Yes or No"
            row.tag = "Adopted"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            
        }
        <<< IntRow() { row in
            row.title = " Pet Age"
            row.placeholder = "Enter Age"
            row.tag = "Age"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            
        }
        <<< TextRow() { row in
            row.title = " Pet Gender"
            row.placeholder = "Enter Your Pet Gender"
            row.tag = "Gender"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            
        }
        <<< URLRow() { row in
            row.title = " Pet Image URL"
            row.placeholder = "Enter Your Pet Image URL"
            row.tag = "Image"
            row.add(rule: RuleURL())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            
        }
        +++ Section("")
        <<< ButtonRow() { row in
            row.title = "ADD PET"
            row.onCellSelection { cell, row in
                print("button cell tapped")
                self.submitTapped()
            }}
        
    }
    @objc func submitTapped(){
        
        //validation
        let errors = form.validate()
        guard errors.isEmpty else{
            print("Somthing is missing!")
            print(errors)
            let countError = errors.count
            presentAlertWithTitle(title: "error!!", message: " \(countError) TextFields empty")
            return
        }
        
        
        
        let idRow: TextRow? = form.rowBy(tag: "ID")
        let id = idRow?.value ?? ""
        
        let nameRow: TextRow? = form.rowBy(tag: "Name")
        let name = nameRow?.value ?? ""
        
        let adoptedRow: TextRow? = form.rowBy(tag: "Adopted")
        let adopted = adoptedRow?.value ?? ""
        
        let ageRow: TextRow? = form.rowBy(tag: "Age")
        let age = ageRow?.value ?? ""
        
        let genderRow: TextRow? = form.rowBy(tag: "Gender")
        let gender = genderRow?.value ?? ""
        
        let imageRow: URLRow? = form.rowBy(tag: "Image")
        let image = imageRow?.value?.absoluteString ?? ""
        
        
        let pet = Pet(id:0, name: name, adopted: Bool(adopted) ?? false, image: image, age: Int(age) ?? 0, gender: gender)
        
        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true,completion: nil)
                }else{
                    print("error")
                }
            }
        }
    }
    
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
