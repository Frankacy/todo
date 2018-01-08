//
//  DatePickerVIew.swift
//  todo
//
//  Created by Francois Courville on 2017-12-28.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate: class {
    func didClearDateSelection(in view: DatePickerView)
    func didSubmitDateSelection(in view: DatePickerView)
    func didCancelDateSelection(in view: DatePickerView)
}

class DatePickerView: UIView {
    weak var delegate: DatePickerViewDelegate?
    var selectedDate: Date? {
        didSet {
            if let selectedDate = selectedDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .short
                textField.text = formatter.string(from: selectedDate)
            } else {
                textField.text = nil
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        get {
            return textField.intrinsicContentSize
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.createView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createView() {
        addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
    }

    @objc func handleCancelButtonPressed(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
        delegate?.didCancelDateSelection(in: self)
    }

    @objc func handleOkButtonPressed(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
        delegate?.didSubmitDateSelection(in: self)
    }

    @objc func handleDateValueChanged(sender: UIDatePicker) {
        selectedDate = datePicker.date
    }

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Due date (optional)"
        textField.clearButtonMode = .unlessEditing

        textField.inputView = datePicker
        textField.inputAccessoryView = datePickerToolbar

        return textField
    }()

    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.minimumDate = Date()
        view.addTarget(self, action: #selector(handleDateValueChanged(sender:)), for: .valueChanged)

        return view
    }()

    lazy var datePickerToolbar: UIToolbar = {
        let view = UIToolbar()
        view.translatesAutoresizingMaskIntoConstraints = false

        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButtonPressed(sender:)))
        let okBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(handleOkButtonPressed(sender:)))

        view.items = [cancelBarButtonItem, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), okBarButtonItem]

        return view
    }()
}
