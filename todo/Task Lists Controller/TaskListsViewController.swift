//
//  TaskListsViewController.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

protocol TaskListsViewControllerDelegate: class {
    func didSelect(taskList: TaskList, in controller: TaskListsViewController)
    func didSelectCreateNewTaskList(in controller: TaskListsViewController)
}

class TaskListsViewController: UIViewController {
    weak var delegate: TaskListsViewControllerDelegate?
    let dataSource: TaskListsDataSource

    init(dataSource: TaskListsDataSource) {
        self.dataSource = dataSource

        super.init(nibName: nil, bundle: nil)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New List",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didSelectNewTaskList(sender:)))
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.reloadData()
    }

    @objc func didSelectNewTaskList(sender: UIBarButtonItem) {
        delegate?.didSelectCreateNewTaskList(in: self)
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
}

extension TaskListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = dataSource.taskList(at: indexPath) else {
            fatalError()
        }

        delegate?.didSelect(taskList: list, in: self)
    }
}

