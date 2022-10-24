////
////  Presenter.swift
////  LoginForm-RSSchool.swift.task7
////
////  Created by Mikita  on 23/10/2022.
////
//
//import Foundation
//import UIKit
//
//
//class LoginPresenter {
//    
//    private enum State {
//        case normal
//        case success
//        case error
//    }
//    
//    private var currentState: State = .normal {
//        didSet {
//            handleStateChanging()
//        }
//    }
//    
//    weak var delegate: LoginDelegate?
//    
//    private func handleStateChanging() {
//        switch currentState {
//        case .normal:
//            delegate?.setupNormalState()
//        case .error:
//            delegate?.setupErrorState()
//        case .success:
//            delegate?.setupSuccessState()
//        }
//    }
//    
//    func passCode(value: Int) {
//        
//    }
//}
//
//protocol LoginDelegate: AnyObject {
//    func setupNormalState()
//    func setupErrorState()
//    func setupSuccessState()
//}
//
//extension LoginScreenViewController: LoginDelegate {
//    func setupNormalState() {
//        loginTextField.isEnabled = true
//        loginTextField.text = ""
//        loginTextField.layer.borderColor = ConstantsOfColors.blackColor.cgColor
//        loginTextField.textColor = ConstantsOfColors.blackColor
//        
//        passTextField.isEnabled = true
//        passTextField.text = ""
//        passTextField.layer.borderColor = ConstantsOfColors.blackColor.cgColor
//        passTextField.textColor = ConstantsOfColors.blackColor
//        
//        secureUILabel.text = ""
//        secureUILabel.isHidden = true
//        secureView.isHidden = true
//        firstSecureNum.isHidden = true
//        secondSecureNum.isHidden = true
//        thirdSecureNum.isHidden = true
//        
//        invisibleButtonToLogin.isHidden = true
//        invisibleButtonToPass.isHidden = true
//    }
//    
//    func setupErrorState() {
//        //        ConstantsOfColors.redColor.cgColor
//    }
//    
//    func setupSuccessState() {
//        
//    }
//}
//
//final class LoginScreenViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
//    
//    
//    //    private var currentState: State = .normal {
//    //        didSet {
//    //            handleStateChanging()
//    //        }
//    //    }
//    //
//    //    func handleStateChanging() {
//    //        switch currentState {
//    //            case .normal:
//    //                setupNormalState()
//    //            case .error:
//    //                setupErrorState()
//    //            case .success:
//    //                setupSuccessState()
//    //        }
//    //    }
//    
//    
//    
//    //    // https://refactoring.guru/design-patterns/state
//    //    func changeState(to state: State) {
//    //        switch currentState {
//    //            case .success:
//    //                break
//    //            case .error:
//    //                break
//    //            case .normal:
//    //                switch state {
//    //                    case .success, .error:
//    //                        currentState = state
//    //                    case .normal:
//    //                        break
//    //                }
//    //        }
//    //    }
