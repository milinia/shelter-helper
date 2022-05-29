//
//  FirebaseManager.swift
//  project
//
//  Created by Evelina on 13.03.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol FirebaseManager: AnyObject{
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void))
    func login(email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void))
    func resetPassword(email: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void))
    func getAccountInfo(completion: @escaping ((Result<DataSnapshot, Error>) -> Void))
    func getAccountCardsInfo(completion: @escaping ((Result<DataSnapshot, Error>) -> Void))
}

class FirebaseManagerImpl: FirebaseManager {
    
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                completion(.success(result))
            }
            else{
                completion(.failure(error!))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                completion(.success(authResult))
            }
            else{
                completion(.failure(error!))
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                completion(.success(nil))
            }
            else{
                completion(.failure(error!))
            }
        }
    }
    
    func getAccountInfo(completion: @escaping ((Result<DataSnapshot, Error>) -> Void)) {
        
        if let userId = Auth.auth().currentUser?.uid {
            let ref: DatabaseReference! = Database.database(url: "https://shelter-helper-160bf-default-rtdb.europe-west1.firebasedatabase.app/").reference()
            ref.child(userId).getData { error, snapshot in
                if error != nil {
                    completion(.failure(error!))
                } else {
                    completion(.success(snapshot))
                }
            }
        }
    }
    
    func getAccountCardsInfo(completion: @escaping ((Result<DataSnapshot, Error>) -> Void)) {
        
        if let userId = Auth.auth().currentUser?.uid {
            let ref: DatabaseReference! = Database.database(url: "https://shelter-helper-160bf-default-rtdb.europe-west1.firebasedatabase.app/").reference()
            ref.child(userId).child("cards").getData { error, snapshot in
                if error != nil {
                    completion(.failure(error!))
                } else {
                    completion(.success(snapshot))
                }
            }
        }
    }
}
