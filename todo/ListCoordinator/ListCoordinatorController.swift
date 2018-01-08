//
//  ListCoordinatorViewController.swift
//  todo
//
//  Created by Francois Courville on 2017-12-25.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

class ListCoordinatorController: UIViewController {
    let rootNavController: UINavigationController
    let dataStore: TaskDataStore = TaskDataStore()

    init() {
        let dataSource = TaskListsDataSource(dataStore: dataStore)
        let rootViewController = TaskListsViewController(dataSource: dataSource)
        self.rootNavController = UINavigationController(rootViewController: rootViewController)

        super.init(nibName: nil, bundle: nil)

        rootViewController.delegate = self
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

    func transition(to taskList: TaskList) {
        let controller = TasksViewController(taskList: taskList)
        controller.delegate = self
        rootNavController.pushViewController(controller, animated: true)

        controller.loadContent()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCoordinatorController: TasksViewControllerDelegate {
    func didSelect(task: Task, in controller: TasksViewController) {
        task.toggleCompletion()
        controller.loadContent()
    }

    func didSelectAddNewTask(in controller: TasksViewController) {
        let coordinator = NewTaskCoordinatorController(for: controller.taskList)
        coordinator.delegate = self

        rootNavController.present(coordinator, animated: true)
    }
}

extension ListCoordinatorController: TaskListsViewControllerDelegate {
    func didSelect(taskList: TaskList, in controller: TaskListsViewController) {
        transition(to: taskList)
    }

    func didSelectCreateNewTaskList(in controller: TaskListsViewController) {
        let alertController = UIAlertController(title: "New List", message: "Enter a name", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dataStore.addNewList(named: alertController.textFields![0].text!)
            controller.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        rootNavController.present(alertController, animated: true)
    }
}

extension ListCoordinatorController : NewTaskCoordinatorControllerDelegate {
    func didCancel(in coordinator: NewTaskCoordinatorController) {
        dismiss(animated: true)
    }

    func didComplete(with newTask: Task, for taskList: TaskList, in coordinator: NewTaskCoordinatorController) {
        dataStore.addTask(task: newTask, to: taskList)
        dismiss(animated: true) {
            guard let vc = self.rootNavController.viewControllers[1] as? TasksViewController else { return }
            vc.tableView.reloadData()
        }
    }
}
