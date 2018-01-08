//
//  TaskListsDataSource.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

class TaskListsDataSource: NSObject {
    let dataStore: TaskDataStore

    init(dataStore: TaskDataStore) {
        self.dataStore = dataStore

        super.init()
    }

    func registerTableView(_ tableView: UITableView) {
        tableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: "TaskListCell")
    }

    func taskList(at indexPath: IndexPath) -> TaskList? {
        guard indexPath.section < 2 else {
            fatalError("Index Path out of bounds")
        }

        let list = indexPath.section == 0 ? [dataStore.inbox] : dataStore.userLists
        return list[indexPath.row]
    }
}

extension TaskListsDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return dataStore.userLists.count
        default:
            fatalError("Too many sections in TaskListsDataSource")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath) as? TaskListTableViewCell else {
            fatalError()
        }

        guard let list = taskList(at: indexPath) else {
            fatalError()
        }
        
        cell.update(with: list)

        return cell
    }
}
