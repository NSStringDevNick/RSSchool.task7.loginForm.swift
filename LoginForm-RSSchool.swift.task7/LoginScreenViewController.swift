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
    private var secureUITextFieldTitle: String = ""
    private var secureUITextFieldTitleO: String = ""
    private var secureUITextFieldNumbers: [Int] = []
    private var countLoginInputText: Int = 0
    private var countPassInputText: Int = 0
    
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
        field.setTextField(delegate: self,
                           placeholder: "enter login",
                           borderStyle: UITextField.BorderStyle.roundedRect,
                           tintColor: ConstantsOfColors.blackCoralDefoltColor,
                           borderColor: ConstantsOfColors.blackColor.cgColor,
                           borderWidth: 1.0,
                           cornerRadius: 5.0,
                           isSecureTextEntry: false as NSSecureCoding,
                           autocapitalizationType: .none)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passTextField: UITextField = {
        let field = UITextField()
        field.setTextField(delegate: self,
                           placeholder: "enter pass",
                           borderStyle: UITextField.BorderStyle.roundedRect,
                           tintColor: ConstantsOfColors.blackCoralDefoltColor,
                           borderColor: ConstantsOfColors.blackColor.cgColor,
                           borderWidth: 1.0,
                           cornerRadius: 5.0,
                           isSecureTextEntry: true as NSSecureCoding,
                           autocapitalizationType: .none)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let authorizeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = ConstantsOfColors.littleBoyBlueColor.cgColor
        button.tintColor = ConstantsOfColors.littleBoyBlueColor
        return button
    }()
    
    private let authorizeButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "authorize"
        label.textColor = ConstantsOfColors.littleBoyBlueColor
        label.font = UIFont(name: "Semibold", size: label.font.pointSize)?.withSize(20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorizeButtonImage: UIImageView = {
        let image = UIImage(systemName: "person")?.withTintColor(ConstantsOfColors.littleBoyBlueColor, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private var secureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setViewBorderAndColor(borderColor: ConstantsOfColors.turquoiseGreenColor.cgColor , borderWith: 2.0, borderCornerRadius: 10)
        view.isHidden = true
        return view
    }()
    
    private var secureUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.isHidden = true
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private func createRoundButton(title: String) -> RoundButton {
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
    private lazy var firstSecureNum: RoundButton = createRoundButton(title: "1")
    private lazy var secondSecureNum: RoundButton = createRoundButton(title: "2")
    private lazy var thirdSecureNum: RoundButton = createRoundButton(title: "3")
    
    private var invisibleButtonToLogin: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private var invisibleButtonToPass: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private enum ConstantsOfColors {
        static let redColor = UIColor(red: 194.0/255.0, green: 1.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        static let whiteColor = UIColor(red: 255.0, green: 255.0, blue: 255.0 , alpha: 1.0)
        static let blackCoralDefoltColor = UIColor(red: 76.0/255.0, green: 92.0/255.0, blue: 104.0/255.0, alpha: 1.0)
        static let turquoiseGreenColor = UIColor(red: 145/255, green: 199/255, blue: 177/255, alpha: 1.0)
        static let venetianRedErrorColor = UIColor(red: 194/255, green: 1/255, blue: 20/255, alpha: 1.0)
        static let blackColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        static let littleBoyBlueColor = UIColor(red: 128/255, green: 164/255, blue: 237/255, alpha: 1.0)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        overrideUserInterfaceStyle = .light
        createViews()
        createConstraintsInit()
        
    }
    
    //MARK: -create views
    private func createViews (){
        
        
        // Label RSSchool
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
        view.addSubview(secureView)
        
        //create 1...3 buttons
        firstSecureNum.addTarget(self, action: #selector(addOneToSecureUILabel), for: .touchUpInside)
        view.addSubview(firstSecureNum)
        secondSecureNum.addTarget(self, action: #selector(addTwoToSecureUILabel), for: .touchUpInside)
        view.addSubview(secondSecureNum)
        thirdSecureNum.addTarget(self, action: #selector(addThreeToSecureUILabel), for: .touchUpInside)
        view.addSubview(thirdSecureNum)
        
        //create secure input code
        secureUILabel.text = secureUITextFieldTitle
        view.addSubview(secureUILabel)
        
        invisibleButtonToLogin.addTarget(self, action: #selector(defaultTextField), for: .touchUpInside)
        loginTextField.addSubview(invisibleButtonToLogin)
        
        invisibleButtonToPass.addTarget(self, action: #selector(defaultTextField), for: .touchUpInside)
        passTextField.addSubview(invisibleButtonToPass)
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
            
            invisibleButtonToLogin.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 80),
            invisibleButtonToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            invisibleButtonToLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            invisibleButtonToLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            //TextField pass
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            passTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            invisibleButtonToPass.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            invisibleButtonToPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            invisibleButtonToPass.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            invisibleButtonToPass.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            //authorize Button
            authorizeButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 60),
            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizeButton.widthAnchor.constraint(equalToConstant: 156),
            authorizeButton.heightAnchor.constraint(equalToConstant: 42),
            
            
            //authorize Button label
            authorizeButtonLabel.topAnchor.constraint(equalTo: authorizeButton.topAnchor, constant: 10),
            authorizeButtonLabel.bottomAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: -10),
            authorizeButtonLabel.trailingAnchor.constraint(equalTo: authorizeButton.trailingAnchor, constant: -20),
            
            //authorize Button image
            authorizeButtonImage.topAnchor.constraint(equalTo: authorizeButton.topAnchor, constant: 10),
            authorizeButtonImage.bottomAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: -10),
            authorizeButtonImage.leadingAnchor.constraint(equalTo: authorizeButton.leadingAnchor, constant: 20),
            authorizeButtonImage.trailingAnchor.constraint(equalTo: authorizeButtonLabel.leadingAnchor, constant: -5),
            authorizeButtonImage.widthAnchor.constraint(equalTo: authorizeButtonImage.heightAnchor, multiplier: 1),
            
            
            //secure view
            secureView.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 67),
            secureView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secureView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 50),
            
            secureView.leadingAnchor.constraint(equalTo:  firstSecureNum.leadingAnchor, constant: -23),
            
            firstSecureNum.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 45),
            //            firstSecureNum.widthAnchor.constraint(equalToConstant: 50),
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
            errorUserInput()
            
        }
    }
    
    func errorUserInput(){
        loginTextField.layer.borderColor = ConstantsOfColors.redColor.cgColor
        //        loginTextField.isEnabled = false
        passTextField.layer.borderColor = ConstantsOfColors.redColor.cgColor
        passTextField.isEnabled = false
        invisibleButtonToPass.isHidden = false
        invisibleButtonToLogin.isHidden = false
        print("error")
        
    }
    
    
    
    //    private var secureUITextFieldTitle: String = ""
    //    private var secureUITextFieldNumbers: [String] = []
    
    
    //    MARK: -FIX
    //    @objc func addNumberToSecureUILabel(number: Int){
    //        secureUITextFieldNumbers.append(number)
    //        let intToString = secureUITextFieldNumbers.map(String.init)
    //        secureUITextFieldTitle = intToString.joined(separator:" ")
    //        secureUILabel.text = "\(secureUITextFieldTitle)"
    //        print("\(number)")
    //        if secureUITextFieldNumbers.count == 3{
    //            checkSecureCode()
    //        }
    //    }
    @objc func addOneToSecureUILabel(){
        secureUITextFieldNumbers.append(1)
        let intToString = secureUITextFieldNumbers.map(String.init)
        secureUITextFieldTitle = intToString.joined(separator:" ")
        secureUILabel.text = "\(secureUITextFieldTitle)"
        print("1")
        if secureUITextFieldNumbers.count == 3{
            checkSecureCode()
        }
    }
    @objc func addTwoToSecureUILabel(){
        secureUITextFieldNumbers.append(2)
        let intToString = secureUITextFieldNumbers.map(String.init)
        secureUITextFieldTitle = intToString.joined(separator:" ")
        secureUILabel.text = "\(secureUITextFieldTitle)"
        print("2")
        if secureUITextFieldNumbers.count == 3{
            checkSecureCode()
        }
        
    }
    @objc func addThreeToSecureUILabel(){
        secureUITextFieldNumbers.append(3)
        let intToString = secureUITextFieldNumbers.map(String.init)
        secureUITextFieldTitle = intToString.joined(separator:" ")
        secureUILabel.text = "\(secureUITextFieldTitle)"
        print("3")
        print(secureUITextFieldNumbers)
        if secureUITextFieldNumbers.count == 3{
            checkSecureCode()
        }
    }
    
    func checkSecureCode(){
        if secureUITextFieldNumbers.count == 3 && secureUITextFieldNumbers == [1, 2, 3]{
            showAlert()
        }else{
            createDefaultState()
        }
    }
    
    func showSecureNumber(){
        loginTextField.layer.borderColor = ConstantsOfColors.turquoiseGreenColor.withAlphaComponent(0.5).cgColor
        loginTextField.isEnabled = false
        loginTextField.textColor = ConstantsOfColors.blackCoralDefoltColor.withAlphaComponent(0.5)
        passTextField.layer.borderColor = ConstantsOfColors.turquoiseGreenColor.withAlphaComponent(0.5).cgColor
        passTextField.isEnabled = false
        passTextField.textColor = ConstantsOfColors.blackCoralDefoltColor.withAlphaComponent(0.5)
        
        authorizeButtonImage.tintColor = ConstantsOfColors.littleBoyBlueColor.withAlphaComponent(0.5)
        authorizeButtonLabel.tintColor = ConstantsOfColors.littleBoyBlueColor.withAlphaComponent(0.5)
        authorizeButton.layer.borderColor = ConstantsOfColors.littleBoyBlueColor.withAlphaComponent(0.5).cgColor
        
        firstSecureNum.isHidden = false
        secondSecureNum.isHidden = false
        thirdSecureNum.isHidden = false
        secureUILabel.isHidden = false
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Welcome", message: "You are successfuly authorized!" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertAction.Style.destructive, handler: {_ in
            self.createDefaultState()
        }))
        
        self.present(alert, animated: true, completion: nil)
        secureView.layer.borderColor = ConstantsOfColors.turquoiseGreenColor.cgColor
        secureView.isHidden = false
    }
    
    @objc func defaultTextField(){
        
        createDefaultState()
    }
    
    func createDefaultState(){
        loginTextField.isEnabled = true
        loginTextField.text = ""
        loginTextField.layer.borderColor = ConstantsOfColors.blackColor.cgColor
        loginTextField.textColor = ConstantsOfColors.blackColor
        
        passTextField.isEnabled = true
        passTextField.text = ""
        passTextField.layer.borderColor = ConstantsOfColors.blackColor.cgColor
        passTextField.textColor = ConstantsOfColors.blackColor
        
        secureUILabel.text = ""
        secureUILabel.isHidden = true
        secureView.isHidden = true
        firstSecureNum.isHidden = true
        secondSecureNum.isHidden = true
        thirdSecureNum.isHidden = true
        
        invisibleButtonToLogin.isHidden = true
        invisibleButtonToPass.isHidden = true
    }
    
}


extension UIView {
    public func setViewBorderAndColor(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
        
    }
}

extension UITextField{
    public func setTextField(delegate:UITextFieldDelegate, placeholder: String,
                             borderStyle: BorderStyle, tintColor: UIColor,
                             borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat, isSecureTextEntry : NSSecureCoding, autocapitalizationType: UITextAutocapitalizationType){
        self.delegate = delegate
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.tintColor = tintColor
        self.borderStyle = borderStyle
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.isSecureTextEntry = isSecureTextEntry as! Bool
        self.autocapitalizationType = autocapitalizationType
    }
}
