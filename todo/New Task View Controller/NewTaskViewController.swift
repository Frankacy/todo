//
//  NewTaskViewController.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

protocol NewTaskViewControllerDelegate: class {
    func didCreateTask(task: Task, in controller: NewTaskViewController)
}

class NewTaskViewController: UIViewController {
    weak var delegate: NewTaskViewControllerDelegate?

    private var selectedDueDate: Date?
    private var selectedTaskName: String = ""

    private var didCreateConstraints: Bool = false

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)

        view.addSubview(taskNameTextField)
        view.addSubview(dueDateTextField)
        view.addSubview(newTaskButton)

        self.view = view
    }

    override func updateViewConstraints() {
        if !didCreateConstraints {
            didCreateConstraints = true
            createConstraints()
        }

        super.updateViewConstraints()
    }

    func createConstraints() {
        NSLayoutConstraint.activate([
            taskNameTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            taskNameTextField.heightAnchor.constraint(equalToConstant: 45),

            dueDateTextField.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 10),
            dueDateTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            dueDateTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            dueDateTextField.heightAnchor.constraint(equalToConstant: 45),
            ])

        if view.safeAreaInsets.bottom > 0 {
            newTaskButton.layer.cornerRadius = 5.0
            NSLayoutConstraint.activate([
                newTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom),
                newTaskButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
                newTaskButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
                newTaskButton.heightAnchor.constraint(equalToConstant: 60)
                ])
        } else {
            NSLayoutConstraint.activate([
                newTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                newTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                newTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                newTaskButton.heightAnchor.constraint(equalToConstant: 60)
                ])
        }
    }

    @objc func handleTaskNameTextFieldValueChanged(sender: UITextField) {
        if let text = sender.text {
            selectedTaskName = text
        }
    }

    @objc func handleNewTaskButtonTapped(sender: UIButton ) {
        let task = Task(name: selectedTaskName, dueDate: selectedDueDate)

        delegate?.didCreateTask(task: task, in: self)
    }

    lazy var taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1

        textField.placeholder = "Task name"
        textField.addTarget(self, action: #selector(handleTaskNameTextFieldValueChanged(sender:)), for: .editingChanged)

        return textField
    }()

    lazy var dueDateTextField: DatePickerView = {
        let view = DatePickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.delegate = self

        return view
    }()

    let newTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Add New Task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleNewTaskButtonTapped(sender:)), for: .touchUpInside)

        return button
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewTaskViewController: DatePickerViewDelegate {
    func didClearDateSelection(in view: DatePickerView) {
        selectedDueDate = nil
    }

    func didSubmitDateSelection(in view: DatePickerView) {
        selectedDueDate = view.selectedDate
    }

    func didCancelDateSelection(in view: DatePickerView) {
        view.selectedDate = selectedDueDate
    }
}

