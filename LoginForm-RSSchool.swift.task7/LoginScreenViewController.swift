//
//  LoginScreenViewController.swift
//  LoginForm-RSSchool.swift.task7
//
//  Created by Mikita  on 01/09/2022.
//


import UIKit
import Foundation


//    //MARK: - create views
//
//        private let labelView: UILabel = {
//            let label = UILabel()
//            label.frame = CGRect(x: 0, y: 0, width: 150, height: 23)
//
//            label.text = "RSSchool"
//            label.font = UIFont.boldSystemFont(ofSize: 36)
//            //        field.center = self.view.center
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.backgroundColor = UIColor.green
//            return label
//        }()

final class RoundButton: UIButton {
    private let radius: CGFloat
    
    init(radius: CGFloat) {
        self.radius = radius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        radius = .zero
        super.init(coder: coder)
    }
    
    //    override func draw(_ rect: CGRect) {
    //        let path = CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
    //    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // перерисовывать границу круга тут
        // потому что тут идёт перерасчёт лейаута
        // https://medium.com/compass-true-north/a-conceptual-guide-to-auto-layout-e41d7a0c4c2b
        layer.cornerRadius = radius
        
    }
}

final class LoginPresenter {
    
    private enum State {
        case normal
        case success
        case error
    }
    
    private var currentState: State = .normal {
        didSet {
            handleStateChanging()
        }
    }
    
    weak var delegate: LoginDelegate?
    
    private func handleStateChanging() {
        switch currentState {
        case .normal:
            delegate?.setupNormalState()
        case .error:
            delegate?.setupErrorState()
        case .success:
            delegate?.setupSuccessState()
        }
    }
    
    func passCode(value: Int) {
        
    }
}

protocol LoginDelegate: AnyObject {
    func setupNormalState()
    func setupErrorState()
    func setupSuccessState()
}

extension LoginScreenViewController: LoginDelegate {
    func setupNormalState() {
        view.layer.borderColor = ConstantsOfColors.turquoiseGreenColor.cgColor
//        ConstantsOfColors.blackCoralDefoltColor.cgColor
    }
    
    func setupErrorState() {
//        ConstantsOfColors.redColor.cgColor
    }
    
    func setupSuccessState() {
//        ConstantsOfColors.turquoiseGreenColor.cgColor
    }
}

final class LoginScreenViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //    let view2: UIView = {
    //        let view = UIView()
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        view.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
    //        view.layer.backgroundColor = UIColor.green.cgColor
    //        return view
    //    }()
    
    //    private var currentState: State = .normal {
    //        didSet {
    //            handleStateChanging()
    //        }
    //    }
    //
    //    func handleStateChanging() {
    //        switch currentState {
    //            case .normal:
    //                setupNormalState()
    //            case .error:
    //                setupErrorState()
    //            case .success:
    //                setupSuccessState()
    //        }
    //    }
    
    
    
    //    // https://refactoring.guru/design-patterns/state
    //    func changeState(to state: State) {
    //        switch currentState {
    //            case .success:
    //                break
    //            case .error:
    //                break
    //            case .normal:
    //                switch state {
    //                    case .success, .error:
    //                        currentState = state
    //                    case .normal:
    //                        break
    //                }
    //        }
    //    }
    
    private var loginInputText: String = ""
    private var passInputText: String = ""
    
    private var labelView = UILabel()
    
    private lazy var loginTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "enter login"
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.tintColor = ConstantsOfColors.blackColor
        field.layer.borderColor = UIColor.black.cgColor
        //        loginTextField.layer.borderColor = BorderState.naDefoltychah
        field.layer.borderWidth = 1.0
        loginTextField.layer.cornerRadius = 5.0

        return field
    }()
    private var passTextField = UITextField()
    private var authorizeButton = UIButton()
    private let authorizeButtonLabel = UILabel()
    
    private var secureView = UIView()
    private var firstSecureNum = UIButton()
    private var secondSecureNum = UIButton()
    private var thirdSecureNum = UIButton()
    
    private enum ConstantsOfColors {
        static let redColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        static let whiteColor = UIColor(red: 255.0, green: 255.0, blue: 255.0 , alpha: 1.0)
        static let blackCoralDefoltColor = UIColor(red: 76, green: 92, blue: 104, alpha: 1.0)
        static let turquoiseGreenColor = UIColor(red: 145, green: 199, blue: 177, alpha: 1.0)
        static let venetianRedErrorColor = UIColor(red: 194, green: 1, blue: 20, alpha: 1.0)
        static let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        static let littleBoyBlueColor = UIColor(red: 128, green: 164, blue: 237, alpha: 1.0)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        createViews()
        createConstraintsInit()
        
    }
    
    //MARK: -create views
    private func createViews (){
        
        
        // Label RSSchool
        let myLabelView = CGRect(x: 0, y: 0, width: 150, height: 23)
        labelView.frame = myLabelView
        labelView.text = "RSSchool"
        labelView.font = UIFont.boldSystemFont(ofSize: 36)
        labelView.center = self.view.center
        labelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelView)
        
        //Login textField
//        let myTextFieldView = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 36, height: 30)
//        loginTextField.frame = myTextFieldView
//        loginTextField.delegate = self
//        loginTextField.autocapitalizationType = .none
//        loginTextField.translatesAutoresizingMaskIntoConstraints = false
//        loginTextField.placeholder = "enter login"
//        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
//        loginTextField.tintColor = ConstantsOfColors.blackColor
//        loginTextField.layer.borderColor = UIColor.black.cgColor
//        //        loginTextField.layer.borderColor = BorderState.naDefoltychah
//        loginTextField.layer.borderWidth = 1.0
//        loginTextField.layer.cornerRadius = 5.0
        view.addSubview(loginTextField)
        
        //Pass textField
        let myPassFieldView = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 36, height: 30)
        passTextField.frame = myPassFieldView
        passTextField.delegate = self
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.placeholder = "enter pass"
        passTextField.isSecureTextEntry = true
        passTextField.autocapitalizationType = .none
        passTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passTextField.tintColor = ConstantsOfColors.blackCoralDefoltColor
        passTextField.layer.borderWidth = 1.0
        passTextField.layer.cornerRadius = 5.0
        view.addSubview(passTextField)
        
        //Authorize Button
        _ = authorizeButton
//        authorizeButton.frame = myAuthorizeButton
        authorizeButton.translatesAutoresizingMaskIntoConstraints = false
        authorizeButton.layer.cornerRadius = 5.0
        authorizeButton.layer.borderWidth = 1.0
        authorizeButton.layer.borderColor = UIColor.blue.cgColor
        authorizeButton.setTitle("authorize", for: .normal)
        authorizeButton.setTitleColor(UIColor.blue, for: .normal)
        authorizeButton.tintColor = UIColor.blue
        authorizeButton.setTitleColor(ConstantsOfColors.blackColor, for: .normal)
        authorizeButton.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        view.addSubview(authorizeButton)
        
//        let myAuthorizeButtonLabel
        
        //MARK: -secure view
        let mySecureView = CGRect(x: 0, y: 0, width: 220, height: 400)
        secureView.frame = mySecureView
        secureView.translatesAutoresizingMaskIntoConstraints = false
//        secureView.layer.backgroundColor = UIColor.blue.cgColor
        secureView.layer.borderColor = ConstantsOfColors.blackColor.cgColor
        secureView.layer.borderWidth = 2.0
        secureView.layer.cornerRadius = 10.0
        secureView.isHidden = false
        view.addSubview(secureView)
        
        //create 1...3 buttons
        let sizeOfCircle = CGRect(x: 0, y: 0, width: 50, height: 50)
        firstSecureNum.frame = sizeOfCircle
        firstSecureNum.setTitle("1", for: .normal)
        firstSecureNum.setTitleColor(UIColor.blue, for: .normal)
        firstSecureNum.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        firstSecureNum.titleLabel?.textColor = UIColor.blue
        firstSecureNum.layer.masksToBounds = true
        firstSecureNum.translatesAutoresizingMaskIntoConstraints = false
        firstSecureNum.layer.cornerRadius = firstSecureNum.bounds.size.width/2
        firstSecureNum.clipsToBounds = true
        firstSecureNum.layer.backgroundColor = UIColor.green.withAlphaComponent(0.2).cgColor
        firstSecureNum.layer.borderColor = UIColor.blue.cgColor
        firstSecureNum.layer.borderWidth = 1.5
        view.addSubview(firstSecureNum)
        
        secondSecureNum.frame = sizeOfCircle
        secondSecureNum.setTitle("2", for: .normal)
        secondSecureNum.tintColor = UIColor.blue
        secondSecureNum.layer.masksToBounds = true
        secondSecureNum.translatesAutoresizingMaskIntoConstraints = false
        secondSecureNum.layer.cornerRadius = firstSecureNum.bounds.size.width/2
        secondSecureNum.clipsToBounds = true
        secondSecureNum.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
        secondSecureNum.layer.borderColor = UIColor.blue.cgColor
        secondSecureNum.layer.borderWidth = 1.5
        view.addSubview(secondSecureNum)
    
        thirdSecureNum.frame = sizeOfCircle
        thirdSecureNum.setTitle("3", for: .normal)
        thirdSecureNum.layer.masksToBounds = true
        thirdSecureNum.tintColor = UIColor.blue.withAlphaComponent(1)
        thirdSecureNum.translatesAutoresizingMaskIntoConstraints = false
        thirdSecureNum.layer.cornerRadius = firstSecureNum.bounds.size.width/2
        thirdSecureNum.clipsToBounds = true
        thirdSecureNum.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
        thirdSecureNum.layer.borderColor = UIColor.blue.cgColor
        thirdSecureNum.layer.borderWidth = 1.5
        view.addSubview(thirdSecureNum)
        
    }
    
    private func createConstraintsInit(){
        NSLayoutConstraint.activate([
            
            //Label RSSchool
            labelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            //TextField Login
            loginTextField.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 80),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            //TextField pass
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            passTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            //authorize Button
            authorizeButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 60),
            //            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            authorizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110),
            
            //secure view
            // paddings -> constant \ screen size ratio
            secureView.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 67),
            secureView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secureView.heightAnchor.constraint(equalToConstant: 100),
            secureView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 50),
            secureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            secureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            firstSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            firstSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            firstSecureNum.leadingAnchor.constraint(equalTo: secureView.leadingAnchor,constant:  23),
//            firstSecureNum.trailingAnchor.constraint(equalTo: secondSecureNum.leadingAnchor, constant: -23),
            
            secondSecureNum.centerXAnchor.constraint(equalTo: secureView.centerXAnchor),
            secondSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            secondSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            secondSecureNum.leadingAnchor.constraint(equalTo: firstSecureNum.trailingAnchor, constant: 20),
//            secondSecureNum.trailingAnchor.constraint(equalTo: thirdSecureNum.leadingAnchor, constant: -23),
            
            thirdSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            thirdSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            thirdSecureNum.leadingAnchor.constraint(equalTo: secondSecureNum.leadingAnchor, constant: 23),
//            thirdSecureNum.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -23),
            
        ])
    }
    
    @objc func buttonClicked(){
        print("button pressed")
        if loginTextField.text == "login" && passTextField.text == "pass"{
            showSecureView()
            
            //mv to func which works with input numbers in secure view
            showAlert()

        }else{
            print("error")
        }
    }
    
    func showSecureView(){
        secureView.isHidden = false
        secureView.subviews.forEach{ $0.isHidden = false}
        print("secure View")
        
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Welcom", message: "You are successfuly authorized!" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertAction.Style.destructive, handler: {_ in
            self.clearTextFieldsAndViews()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearTextFieldsAndViews(){
        loginTextField.text = ""
        passTextField.text = ""
        secureView.isHidden = true
        secureView.subviews.forEach{ $0.isHidden = true}
    }

}

