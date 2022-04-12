//
//  projectTests.swift
//  projectTests
//
//  Created by Evelina on 24.03.2022.
//

import XCTest
@testable import project

class SignUpModuleTests: XCTestCase {
    
    var signUpPresenter: SignUpPresenter!
    var firebaseManager: FirebaseManagerMock!
    var signUpView: SignUpViewMock!
    var formChecker: FormChecker!
    var alertFactory: AlertFactory!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        firebaseManager = FirebaseManagerMock()
        signUpView = SignUpViewMock()
        formChecker = FormChecker()
        alertFactory = AlertFactory()
        signUpPresenter = SignUpPresenter(formChecker: formChecker, alertFactory: alertFactory, firebaseManager: firebaseManager)
    }
    override func tearDownWithError() throws {
        firebaseManager = nil
        signUpView = nil
        formChecker = nil
        alertFactory = nil
        signUpPresenter = nil
        try super.tearDownWithError()
    }
    func testBadEmailValidation() throws {
        let email = "tet13@mail."
        let result = signUpPresenter.isEmailValid(email: email)
        XCTAssertEqual(result, false)
    }
    func testEmptyEmailValidation() throws {
        let email = ""
        let result = signUpPresenter.isEmailValid(email: email)
        XCTAssertEqual(result, false)
    }
    func testGoodEmailValidation() throws {
        let email = "test@gamil.com"
        let result = signUpPresenter.isEmailValid(email: email)
        XCTAssertEqual(result, true)
    }
    func testBadPasswordValidation() throws {
        let password = "er200"
        let result = signUpPresenter.isPasswordValid(password: password)
        XCTAssertEqual(result, false)
    }
    func testGoodPasswordValidation() throws {
        let password = "ertyu3"
        let result = signUpPresenter.isPasswordValid(password: password)
        XCTAssertEqual(result, true)
    }
    func testIsPerfomingDifferentScreenWorks() throws {
        let email = "test@mail.ru"
        let password = "qwerty11"
        signUpPresenter.signUp(email: email, password: password)
        XCTAssertEqual(signUpView.isNewScreenHadBeenPerfomed, true)
        XCTAssertEqual(signUpView.isAlertHadBeenShowed, false)
    }
    func testisShowingAlertWorks() throws {
        let email = "test@mail"
        let password = "qwerty11"
        signUpPresenter.signUp(email: email, password: password)
        XCTAssertEqual(signUpView.isNewScreenHadBeenPerfomed, false)
        XCTAssertEqual(signUpView.isAlertHadBeenShowed, true)
    }
}
