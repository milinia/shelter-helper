//
//  FireBaseManager_mock.swift
//  projectTests
//
//  Created by Evelina on 27.03.2022.
//

import Foundation
import FirebaseAuth
@testable import project

class FirebaseManagerMock: FirebaseManager {
    
    func login(email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        return completion(.success(nil))
    }
    
    func resetPassword(email: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        return completion(.success(nil))
    }
    
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        return completion(.success(nil))
    }
}
