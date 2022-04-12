//
//  FormChecker.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import Foundation

class FormChecker{
    
    func checkPassword(password: String) -> Bool {
        
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9]).{6,64}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }

    func checkEmail(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    func checkPaymentData(amount: String) -> Bool {
        if amount == "0" {
            return false
        }
        let amountRegEx = "(?=.*[0-9]).{1,10}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", amountRegEx)
        return predicate.evaluate(with: amount)
    }
}
