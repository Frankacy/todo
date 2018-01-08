//
//  TaskListViewController.swift
//  todo
//
//  Created by Francois Courville on 2017-12-25.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

protocol TasksViewControllerDelegate: class {
    func didSelect(task: Task, in controller: TasksViewController)
    func didSelectAddNewTask(in controller: TasksViewController)
}

class TasksViewController: UIViewController {
    weak var delegate: TasksViewControllerDelegate?

    let taskList: TaskList
    let dataSource: TasksDataSource

    init(taskList: TaskList) {
        self.taskList = taskList
        self.dataSource = TasksDataSource(taskList: taskList)

        super.init(nibName: nil, bundle: nil)

        self.navigationItem.title = taskList.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Task", style: .plain, target: self, action: #selector(didSelectNewTask(sender:)))
    }

    override func loadView() {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.registerTableView(tableView)
    }

    @objc func didSelectNewTask(sender: UIBarButtonItem) {
        delegate?.didSelectAddNewTask(in: self)
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self.dataSource
        tableView.delegate = self

        return tableView
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadContent() {
        self.tableView.reloadData()
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = dataSource.task(at: indexPath)

        delegate?.didSelect(task: task, in: self)
    }
}

