//
//  NewTaskCoordinator.swift
//  todo
//
//  Created by Francois Courville on 2017-12-28.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

protocol NewTaskCoordinatorControllerDelegate: class {
    func didCancel(in coordinator: NewTaskCoordinatorController)
    func didComplete(with newTask: Task, for taskList: TaskList, in coordinator: NewTaskCoordinatorController)
}

class NewTaskCoordinatorController: UIViewController {
    weak var delegate: NewTaskCoordinatorControllerDelegate?
    let selectedTaskList: TaskList

    let rootNavController: UINavigationController

    init(for taskList: TaskList) {
        self.selectedTaskList = taskList

        let rootViewController = NewTaskViewController()
        self.rootNavController = UINavigationController(rootViewController: rootViewController)

        super.init(nibName: nil, bundle: nil)

        rootViewController.delegate = self
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                              style: .plain,
                                                                              target: self,
                                                                              action: #selector(handleCloseButtonTapped(sender:)))
    }

    override func viewDidLoad() {
        addChildViewController(rootNavController)
        view.addSubview(rootNavController.view)
        NSLayoutConstraint.activate([
            rootNavController.view.topAnchor.constraint(equalTo: view.topAnchor),
            rootNavController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootNavController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootNavController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        rootNavController.didMove(toParentViewController: self)
    }

    @objc func handleCloseButtonTapped(sender: UIBarButtonItem) {
        delegate?.didCancel(in: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewTaskCoordinatorController: NewTaskViewControllerDelegate {
    func didCreateTask(task: Task, in controller: NewTaskViewController) {
        delegate?.didComplete(with: task, for: selectedTaskList, in: self)
    }
}
