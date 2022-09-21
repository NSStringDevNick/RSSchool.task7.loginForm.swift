//
//  QA.swift
//  LoginForm-RSSchool.swift.task7
//
//  Created by Mikita  on 12/09/2022.
//

import Foundation

//MARK: -QA
/*
 
 1) states?
 2) problems with adding custom UIView

 
*/
//MARK: - tasks
/*
 1)State machine
 
 2)circle views for secure UIView
 3)
 
 */



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

//final class RoundButton: UIButton {
//    private let radius: CGFloat
//    
//    init(radius: CGFloat) {
//        self.radius = radius
//        super.init(frame: .zero)
//    }
//    
//    required init?(coder: NSCoder) {
//        radius = .zero
//        super.init(coder: coder)
//    }
//    
//    //    override func draw(_ rect: CGRect) {
//    //        let path = CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
//    //    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        // перерисовывать границу круга тут
//        // потому что тут идёт перерасчёт лейаута
//        // https://medium.com/compass-true-north/a-conceptual-guide-to-auto-layout-e41d7a0c4c2b
//        layer.cornerRadius = radius
//        
//    }
//}
//
//final class LoginPresenter {
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
//        view.layer.borderColor = ConstantsOfColors.turquoiseGreenColor.cgColor
//        //        ConstantsOfColors.blackCoralDefoltColor.cgColor
//    }
//    
//    func setupErrorState() {
//        //        ConstantsOfColors.redColor.cgColor
//    }
//    
//    func setupSuccessState() {
//        //        ConstantsOfColors.turquoiseGreenColor.cgColor
//    }
//}
//
//
