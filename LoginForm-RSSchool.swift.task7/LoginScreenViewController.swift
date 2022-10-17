//
//  LoginScreenViewController.swift
//  LoginForm-RSSchool.swift.task7
//
//  Created by Mikita  on 01/09/2022.
//


import UIKit
import Foundation


final class RoundButton: UIButton {
//    private let radius: CGFloat
    
//    init(radius: CGFloat) {
//        self.radius = radius
//        super.init(frame: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        radius = .zero
//        super.init(coder: coder)
//    }
    
    //    override func draw(_ rect: CGRect) {
    //        let path = CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
    //    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // перерисовывать границу круга тут
        // потому что тут идёт перерасчёт лейаута
        // https://medium.com/compass-true-north/a-conceptual-guide-to-auto-layout-e41d7a0c4c2b
        layer.cornerRadius = frame.height/2
        
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
    private var secureUILabelTitle: String = ""
    private var secureUILabelNumbers: [Int] = []
    
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.blue.cgColor
        button.tintColor = UIColor.blue
        button.setTitleColor(ConstantsOfColors.blackColor, for: .normal)
        return button
    }()
    
    private let authorizeButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "authorize"
        label.textColor = UIColor.blue
        label.font = UIFont(name: "Semibold", size: label.font.pointSize)?.withSize(20.0)
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
        view.setViewBorderAndColor(borderColor: ConstantsOfColors.turquoiseGreenColor.cgColor , borderWith: 2.0, borderCornerRadius: 10)
//        view.isHidden = true
        return view
    }()
    
    private var secureUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.text = ""
        label.isHidden = true
        return label
    }()
    
    func doThings(title: String) -> RoundButton {
        let button = RoundButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.titleLabel?.textColor = UIColor.blue
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1.5
        button.isHidden = true
        return button
    }
    
    // read proxy pattern
    private lazy var firstSecureNum: RoundButton = doThings(title: "1")
    private lazy var secondSecureNum: RoundButton = doThings(title: "2")
    private lazy var thirdSecureNum: RoundButton = doThings(title: "3")
    
    private enum ConstantsOfColors {
        static let redColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        static let whiteColor = UIColor(red: 255.0, green: 255.0, blue: 255.0 , alpha: 1.0)
        static let blackCoralDefoltColor = UIColor(red: 76.0/255.0, green: 92.0/255.0, blue: 104.0/255.0, alpha: 1.0)
        static let turquoiseGreenColor = UIColor(red: 145/255, green: 199/255, blue: 177/255, alpha: 1.0)
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
        
        //MARK: -secure view
        secureUILabel.setViewBorderAndColor(borderColor: #colorLiteral(red: 0.9, green: 0.9, blue: 0.6, alpha: 1), borderWith: 1.0, borderCornerRadius: 20)
        view.addSubview(secureView)
        
        //create 1...3 buttons
        firstSecureNum.addTarget(self, action: #selector(addOneToSecureUILabel), for: .touchUpInside)
        view.addSubview(firstSecureNum)
        secondSecureNum.addTarget(self, action: #selector(addTwoToSecureUILabel), for: .touchUpInside)
        view.addSubview(secondSecureNum)
        thirdSecureNum.addTarget(self, action: #selector(addThreeToSecureUILabel), for: .touchUpInside)
        view.addSubview(thirdSecureNum)
        
        //create secure input code
        secureUILabel.text = secureUILabelTitle
        view.addSubview(secureUILabel)
    }
    
    private func createConstraintsInit(){
        NSLayoutConstraint.activate([
            
            //Label RSSchool
            labelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            //TextField Login
            loginTextField.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 80),
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

            //authorize Button image
            authorizeButtonImage.topAnchor.constraint(equalTo: authorizeButton.topAnchor, constant: 10),
            authorizeButtonImage.bottomAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: -10),
            authorizeButtonImage.leadingAnchor.constraint(equalTo: authorizeButton.leadingAnchor, constant: 20),
            authorizeButtonImage.trailingAnchor.constraint(equalTo: authorizeButtonLabel.leadingAnchor, constant: -5),
            
            //secure view
            secureView.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 67),
            secureView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secureView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 50),

            secureView.leadingAnchor.constraint(equalTo:  firstSecureNum.leadingAnchor, constant: -23),
            
            firstSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            firstSecureNum.widthAnchor.constraint(equalToConstant: 50),
            firstSecureNum.widthAnchor.constraint(equalTo: firstSecureNum.heightAnchor, multiplier: 1),
            firstSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            firstSecureNum.trailingAnchor.constraint(equalTo: secondSecureNum.leadingAnchor,constant:  -20),
            
            secondSecureNum.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondSecureNum.widthAnchor.constraint(equalToConstant: 50),
            secondSecureNum.widthAnchor.constraint(equalTo: secondSecureNum.heightAnchor, multiplier: 1),
            secondSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            secondSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),

            thirdSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            thirdSecureNum.widthAnchor.constraint(equalToConstant: 50),
            thirdSecureNum.widthAnchor.constraint(equalTo: thirdSecureNum.heightAnchor, multiplier: 1),
            thirdSecureNum.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -15),
            thirdSecureNum.leadingAnchor.constraint(equalTo: secondSecureNum.trailingAnchor, constant: 23),
            
            secureUILabel.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 15),
            secureUILabel.bottomAnchor.constraint(equalTo: secondSecureNum.topAnchor, constant: -15),
            secureUILabel.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 96),
            secureUILabel.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -96),
        ])
    }
    
    @objc func buttonClicked(){
        print("button pressed")
        if loginTextField.text == "login" && passTextField.text == "pass"{
            //mv to func which works with input numbers in secure view
            showSecureNumber()
        }else{
            createDefaultState()
            print("error")
        }
    }
    
    @objc func addOneToSecureUILabel(){
        secureUILabel.text = "1"
        secureUILabelNumbers.append(1)
        checkSecureCode()
        print("1")
    }
    @objc func addTwoToSecureUILabel(){
        secureUILabelNumbers.append(2)
        checkSecureCode()
        print("2")
    }
    @objc func addThreeToSecureUILabel(){
        secureUILabelNumbers.append(3)
        print("3")
        print(secureUILabelNumbers)
        checkSecureCode()
    }
    
    func checkSecureCode(){
        if secureUILabelNumbers.count == 3 && secureUILabelNumbers == [1, 2, 3]{
            showAlert()
        }else{
//            createDefaultState()
        }
//            secureUILabelNumbers.count == 3 && secureUILabelNumbers != [1, 2, 3]{
////                clearTextFieldsAndViews()
//            }
        
    }
    
    func showSecureNumber(){
        firstSecureNum.isHidden = false
        secondSecureNum.isHidden = false
        thirdSecureNum.isHidden = false
        secureUILabel.isHidden = false
    }
    
    func showSecureView(){
        secureView.isHidden = false
        secureView.subviews.forEach{ $0.isHidden = false}
        print("secure View")
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Welcome", message: "You are successfuly authorized!" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertAction.Style.destructive, handler: {_ in
            self.createDefaultState()
        }))
        
        self.present(alert, animated: true, completion: nil)
        secureView.layer.borderColor = UIColor(red:100/255, green:47/255, blue:23/255, alpha: 1).cgColor
        secureView.isHidden = false
    }
    
    func createDefaultState(){
        loginTextField.text = ""
        passTextField.text = ""
        secureView.isHidden = true
        firstSecureNum.isHidden = true
        secondSecureNum.isHidden = true
        thirdSecureNum.isHidden = true
        secureUILabel.isHidden = true
        
    }

}


extension UIView {
    public func setViewBorderAndColor(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius

    }
}
