//
//  ViewController.swift
//  Contacts
//
//  Created by Sain-R Edwards on 1/7/19.
//  Copyright © 2019 Swift Koding 4 Everyone. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellID = "cellID"
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["John", "Carter", "Ashley", "Shawn", "Anthony", "Ernie", "Henry", "Cynthia", "Tony", "Felicia", "Pamela", "Fatai", "Michelle"]),
        ExpandableNames(isExpanded: true, names: ["Carl", "CJ", "Casey", "Cynthia"]),
        ExpandableNames(isExpanded: true, names: ["Darnell", "David", "Doug"])
    ]
    
    var showIndexPaths = true
    
    @objc func handleShowIndexPath() {
        print("Attempting reload animation of indexPaths...")
        
        // Build indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        if showIndexPaths {
            for section in twoDimensionalArray.indices {
                for row in twoDimensionalArray[section].names.indices {
                    print(section, row)
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathsToReload.append(indexPath)
                }
            }
        }
        
//        for index in twoDimensionalArray[0].indices {
//            let indexPath = IndexPath(row: index, section: 0)
//            indexPathsToReload.append(indexPath)
//        }
        
        showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9552876353, green: 0.6610090137, blue: 0.1449919343, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // Close the section first by deleting rows
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        // let name = names[indexPath.row]
        
//        let name = indexPath.section == 0 ? names[indexPath.row] : cNames[indexPath.row]
        
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = name
        
        if showIndexPaths {
            cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell
    }

}

