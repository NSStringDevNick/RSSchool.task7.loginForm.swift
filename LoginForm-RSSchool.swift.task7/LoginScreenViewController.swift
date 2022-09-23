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
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.text = "RSSchool"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var loginTextField = UITextField()
    private lazy var loginTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "enter login"
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.tintColor = ConstantsOfColors.blackColor
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5.0
        return field
    }()
    
    private lazy var passTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "enter pass"
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.tintColor = ConstantsOfColors.blackCoralDefoltColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5.0
        return field
    }()
    
    private let authorizeButton: UIButton = {
        let button = UIButton()
        button.bounds = CGRect(x: 0, y: 0, width: 156, height: 42)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.blue.cgColor
        button.tintColor = UIColor.blue
        button.setTitleColor(ConstantsOfColors.blackColor, for: .normal)
//        button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)   //// TODO: вопросич -------------------
        return button
    }()
    
    private let authorizeButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "authorize"
        label.textColor = UIColor.blue
        label.font = UIFont(name: "Semibold", size: label.font.pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorizeButtonImage: UIImageView = {
        
        let image = UIImage(systemName: "person")?.withTintColor(UIColor.blue, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    
    private var secureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = ConstantsOfColors.blackColor.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 10.0
        view.isHidden = false
        return view
    }()
    
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
        
        
//        // Label RSSchool
        view.addSubview(labelView)
        
        //Login textField
        view.addSubview(loginTextField)
        
        //Pass textField
        view.addSubview(passTextField)
        
        //Authorize Button
        authorizeButton.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        view.addSubview(authorizeButton)
        view.addSubview(authorizeButtonLabel)
        view.addSubview(authorizeButtonImage)
        
//        let myAuthorizeButtonLabel
        
        //MARK: -secure view

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
            authorizeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            authorizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110),
            
            //authorize Button label
            authorizeButtonLabel.topAnchor.constraint(equalTo: authorizeButton.topAnchor, constant: 10),
            authorizeButtonLabel.bottomAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: -10),
            authorizeButtonLabel.trailingAnchor.constraint(equalTo: authorizeButton.trailingAnchor, constant: -20),
//
//            //authorize Button image
            authorizeButtonImage.topAnchor.constraint(equalTo: authorizeButton.topAnchor, constant: 10),
            authorizeButtonImage.bottomAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: -10),
            authorizeButtonImage.leadingAnchor.constraint(equalTo: authorizeButton.leadingAnchor, constant: 20),
            authorizeButtonImage.trailingAnchor.constraint(equalTo: authorizeButtonLabel.leadingAnchor, constant: -5),
            
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
            secondSecureNum.leadingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: 20),
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
        let alert = UIAlertController(title: "Welcome", message: "You are successfuly authorized!" , preferredStyle: UIAlertController.Style.alert)
        
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

