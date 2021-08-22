//
//  ViewController.swift
//  Form
//
//  Created by Dan Koza on 7/25/21.
//

import UIKit
import PopForm

#warning("see if you can fix when changing a phone number the cursor jumps to the end when textField.text is changed")

class ViewController: UIViewController, ValidatableFormDelegate {

    private var form: Form?

    let textField1: UIFormFieldTextField = {
        let textField = UIFormFieldTextField()
        textField.setValidation {
            guard !(textField.text?.isEmpty ?? true) else { return .unknown }
            return textField.text?.lowercased() == textField.placeholder ? .valid : .invalid
        }
        textField.setValidationStateDidChange(handler: { validationState in
            switch validationState {
                case .unknown, .default:
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

    let textField2: UIFormFieldTextField = {
        let textField = UIFormFieldTextField()
        textField.setValidation {
            guard !(textField.text?.isEmpty ?? true) else { return .unknown }
            return textField.text?.lowercased() == textField.placeholder ? .valid : .invalid
        }
        textField.setValidationStateDidChange(handler: { validationState in
            switch validationState {
                case .unknown, .default:
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

    let switchFormField: UIFormFieldSwitch = {
        let switchFormField = UIFormFieldSwitch()
        switchFormField.setValidationStateDidChange(handler: { validationState in
            switchFormField.backgroundColor = validationState == .valid ? .green : .red
        })
        switchFormField.setValidation(predicate: {
            switchFormField.isOn ? .valid : .invalid
        })

        return switchFormField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        form = Form(fields: textField1, textField2, switchFormField, delegate: self)

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
