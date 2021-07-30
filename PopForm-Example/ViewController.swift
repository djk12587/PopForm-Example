//
//  ViewController.swift
//  Form
//
//  Created by Dan Koza on 7/25/21.
//

import UIKit
import ValidatableForm

#warning("see if you can fix when changing a phone number the cursor jumps to the end when textField.text is changed")

class ViewController: UIViewController, ValidatableFormDelegate {

    private var form: ValidatableForm?

    let textField1: UIFormTextField = {
        let textField = UIFormTextField()
        textField.setValidation {
            guard !(textField.text?.isEmpty ?? true) else { return .unknown }
            return textField.text?.lowercased() == textField.placeholder ? .valid : .invalid
        }
        textField.setValidationStateDidChange(handler: {
            switch textField.validationState {
                case .unknown:
                    textField.backgroundColor = nil
                case .invalid:
                    textField.backgroundColor = .red
                case .valid:
                    textField.backgroundColor = .green
            }
        })
        textField.placeholder = "first"
        return textField
    }()

    let textField2: UIFormTextField = {
        let textField = UIFormTextField()
        textField.setValidation {
            guard !(textField.text?.isEmpty ?? true) else { return .unknown }
            return textField.text?.lowercased() == textField.placeholder ? .valid : .invalid
        }
        textField.setValidationStateDidChange(handler: {
            switch textField.validationState {
                case .unknown:
                    textField.backgroundColor = nil
                case .invalid:
                    textField.backgroundColor = .red
                case .valid:
                    textField.backgroundColor = .green
            }
        })
        textField.placeholder = "second"
        return textField
    }()

    let switchFormField: UIFormSwitch = {
        let switchFormField = UIFormSwitch()
        switchFormField.isOn = true
        switchFormField.setValidation {
            switchFormField.isOn ? .valid : .invalid
        }
        switchFormField.setValidationStateDidChange(handler: {
            switchFormField.backgroundColor = switchFormField.isOn ? .green : .red
        }, send: .valueChanged)
        return switchFormField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        form = ValidatableForm(fields: textField1, textField2, switchFormField, delegate: self)

        let stackView = UIStackView(arrangedSubviews: [textField1, textField2, switchFormField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func formValidationChanged(formIsValid: Bool) {
        print("formIsValid: \(formIsValid)")
    }
}
