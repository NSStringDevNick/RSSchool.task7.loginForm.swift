//
//  UIView+Layout.swift
//  LoginForm-RSSchool.swift.task7
//
//  Created by Mikita  on 23/10/2022.
//

import UIKit

extension UIView {
    func pin() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        ])
    }
    
    func pin(to views: [UIView], constants: [CGFloat] = [0,0,0,0] ) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: views[0].topAnchor, constant: constants[0]),
            self.bottomAnchor.constraint(equalTo: views[1].bottomAnchor, constant: constants[1]),
            self.trailingAnchor.constraint(equalTo: views[2].trailingAnchor, constant: constants[2]),
            self.leadingAnchor.constraint(equalTo: views[3].leadingAnchor, constant: constants[3])
        ])
    }
    
    func pin(to view: UIView, constants: [CGFloat] = [0,0,0,0]) {
        pin(to: [view, view, view, view], constants: constants)
    }
}
