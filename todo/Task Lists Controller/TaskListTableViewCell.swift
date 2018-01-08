//
//  TaskListTableViewCell.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import Foundation
import UIKit

class TaskListTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.createView()
    }

    func update(with taskList: TaskList) {
        listNameLabel.text = taskList.name

        let remainingTaskCount = taskList.tasks.filter( { !$0.completed } ).count
        taskCountLabel.text = "\(remainingTaskCount) tasks left"
    }

    func createView() {
        accessoryType = .disclosureIndicator

        contentView.addSubview(listNameLabel)
        contentView.addSubview(taskCountLabel)

        NSLayoutConstraint.activate([
            listNameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            listNameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            listNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            taskCountLabel.topAnchor.constraint(equalTo: listNameLabel.bottomAnchor),
            taskCountLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            taskCountLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            taskCountLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }

    lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black

        return label
    }()

    lazy var taskCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray

        return label
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

