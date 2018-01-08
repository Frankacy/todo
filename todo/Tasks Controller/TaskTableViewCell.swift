//
//  TaskTableViewCell.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import Foundation
import UIKit

class TaskTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.createView()
    }

    func update(with task: Task) {
        taskNameLabel.text = task.name

        if let dueDate = task.dueDate {
            taskDueLabel.text = "Due \(dueDate)"
        } else {
            taskDueLabel.text = "No due date"
        }

        self.accessoryType = task.completed ? .checkmark : .none
    }

    func createView() {
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(taskDueLabel)

        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            taskDueLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor),
            taskDueLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            taskDueLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            taskDueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            ])
    }

    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black

        return label
    }()

    lazy var taskDueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray

        return label
    }()

    //Checkmark view

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
