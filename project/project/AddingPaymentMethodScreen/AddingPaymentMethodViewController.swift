//
//  AddingPaymentMethodViewController.swift
//  project
//
//  Created by Evelina on 25.05.2022.
//

import UIKit

protocol AddingPaymentMethodViewProtocol {
    func showAlert(alert: UIAlertController)
}

class AddingPaymentMethodViewController: UIViewController,  AddingPaymentMethodViewProtocol{
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var monthExpireDateTextField: UITextField!
    @IBOutlet weak var yearExpireDateTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var addingPaymentMethodPresenter: AddingPaymentMethodPresenterProtocol!
    var numberOfUserCards: Int?
    
    let monthPicker = UIPickerView()
    let yearPicker = UIPickerView()
    
    let monthsArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var yearsArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar1.setItems([doneButton1], animated: true)
        toolbar2.setItems([doneButton2], animated: true)
        
        cardNumberTextField.delegate = self
        codeTextField.delegate = self

        monthPicker.dataSource = self
        monthPicker.delegate = self
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        monthExpireDateTextField.inputView = monthPicker
        yearExpireDateTextField.inputView = yearPicker
        
        monthExpireDateTextField.inputAccessoryView = toolbar1
        yearExpireDateTextField.inputAccessoryView = toolbar2
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentYear: Int = Int(dateFormatter.string(from: date)) ?? 2020
        for year in currentYear...currentYear + 10 {
            yearsArray.append(String(year))
        }
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }

    @IBAction func submitAction(_ sender: Any) {
        if addingPaymentMethodPresenter.checkCharactersAmountInString(string: cardNumberTextField.text, neededAmountCharacters: 16) {
            
            if addingPaymentMethodPresenter.checkCharactersAmountInString(string: codeTextField.text, neededAmountCharacters: 3) {
                
                if monthExpireDateTextField.text != "" && yearExpireDateTextField.text != "" {
                    
                    if nameTextField.text != "" {
                        addingPaymentMethodPresenter.addNewCard(card: Card(number: cardNumberTextField.text!,
                                                                           owner: nameTextField.text!,
                                                                           validityPeriod: String(monthsArray.firstIndex(of:
                                                                                                                            monthExpireDateTextField.text!) ?? 0 + 1) + "/" +
                                                                           yearExpireDateTextField.text!,
                                                                           code: codeTextField.text!),
                                                                userCardsNumber: numberOfUserCards ?? 0)
                    } else {
                        errorLabel.isHidden = false
                        errorLabel.text = "Name field must not be empty!"
                    }
                } else {
                    errorLabel.isHidden = false
                    errorLabel.text = "Expire date field must not be empty!"
                }
            } else {
                errorLabel.isHidden = false
                errorLabel.text = "Card security code must contain 3 digits!"
            }
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Card number must contain 16 digits!"
        }
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}

extension AddingPaymentMethodViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == monthPicker {
            return monthsArray.count
        } else if pickerView == yearPicker {
            return yearsArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == monthPicker {
            return monthsArray[row]
        } else if pickerView == yearPicker {
            return yearsArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == monthPicker {
            monthExpireDateTextField.text = monthsArray[row]
        } else if pickerView == yearPicker {
            yearExpireDateTextField.text = yearsArray[row]
        }
    }
}
extension AddingPaymentMethodViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            let allowedCharcterSet = NSCharacterSet.letters
            let typedCharcterSet = CharacterSet(charactersIn: string)
            return allowedCharcterSet.isSuperset(of: typedCharcterSet)
        } else {
            let allowedCharacters = "1234567890"
            let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharcterSet = CharacterSet(charactersIn: string)
            return allowedCharcterSet.isSuperset(of: typedCharcterSet)
        }
    }
}
