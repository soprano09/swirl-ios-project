//
//  AuthCardView.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/10/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol AuthCardViewDelegate: class {
    func loginButtonWasPressed()
}

final class AuthCardView: UIView {
    @IBOutlet fileprivate weak var aboutPageView: UIView!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    @IBOutlet fileprivate weak var bottomLabel: UILabel!
    weak var delegate: AuthCardViewDelegate?

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        loadNib { [weak self] view in self?.setup(view) }
        backgroundColor = UIColor.white.withAlphaComponent(0)
        setupBottomLabel()
        setupLoginButton()
    }

    @IBAction fileprivate func loginButtonWasPressed(_ sender: Any) {
        delegate?.loginButtonWasPressed()
    }
}

fileprivate extension AuthCardView {
    func setup(_ view: UIView) {
        view.backgroundColor = UIColor.white.withAlphaComponent(Constants.alphaValue)
        view.layer.cornerRadius = Constants.viewCornerRadius
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = Constants.viewCornerRadius
    }

    func setupLoginButton() {
        let attributedTitle = NSAttributedString(string: Constants.buttonText, attributes: [
            NSForegroundColorAttributeName: UIColor.blue.withAlphaComponent(Constants.alphaValue),
            NSFontAttributeName: UIFont(name: Constants.futuraFont, size: Constants.largeFontSize) as Any
        ])

        loginButton.setAttributedTitle(attributedTitle, for: .normal)
        loginButton.backgroundColor = UIColor.lightBlue.withAlphaComponent(Constants.alphaValue)
        loginButton.layer.cornerRadius = Constants.buttonCornerRadius
    }

    func setupBottomLabel() {
        let attributedText = NSAttributedString(string: Constants.bottomLabelText, attributes: [
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSFontAttributeName: UIFont(name: Constants.futuraFont, size: Constants.smallFontSize) as Any
        ])

        bottomLabel.attributedText = attributedText
    }
}

private struct Constants {
    static let buttonCornerRadius: CGFloat = 4
    static let viewCornerRadius: CGFloat = 10
    static let shadowOpacity: Float = 0.8
    static let alphaValue: CGFloat = 0.8
    static let smallFontSize: CGFloat = 12
    static let largeFontSize: CGFloat = 24
    static let futuraFont = "Futura-Medium"
    static let buttonText = "Login with Facebook"
    static let bottomLabelText = "We will never post anything to your Facebook ♥️"
}
