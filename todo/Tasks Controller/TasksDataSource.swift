//
//  TasksDataSource.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

enum TasksError: Error {
    case randomError
}

class TasksDataSource: NSObject {
    let taskList: TaskList

    init(taskList: TaskList) {
        self.taskList = taskList
        super.init()
    }

    func registerTableView(_ tableView: UITableView) {
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
    }

    func task(at indexPath: IndexPath) -> Task {
        guard indexPath.section == 0 else { fatalError() }
        guard indexPath.row < taskList.tasks.count else { fatalError() }

        return taskList.tasks[indexPath.row]
    }
}

extension TasksDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            fatalError()
        }

        return taskList.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else {
            fatalError()
        }

        let theTask = task(at: indexPath)
        cell.update(with: theTask)

        return cell
    }
}
