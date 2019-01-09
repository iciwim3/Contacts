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
    
    let names = [
        "John", "Carter", "Ashley", "Shawn", "Anthony", "Ernie", "Henry", "Cynthia", "Tony", "Felicia", "Pamela", "Fatai", "Michelle"
    ]
    
    let cNames = ["Carl", "CJ", "Casey", "Cynthia"]
    
    let dNames = ["Darnell", "David", "Doug"]
    
    let twoDimensionalArray = [
        ["John", "Carter", "Ashley", "Shawn", "Anthony", "Ernie", "Henry", "Cynthia", "Tony", "Felicia", "Pamela", "Fatai", "Michelle"],
        ["Carl", "CJ", "Casey", "Cynthia"],
        ["Darnell", "David", "Doug"]
    ]
    
    var showIndexPaths = true
    
    @objc func handleShowIndexPath() {
        print("Attempting reload animation of indexPaths...")
        
        // Build indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
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
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
//        if section == 0 {
//            return names.count
//        }
//        return cNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        // let name = names[indexPath.row]
        
//        let name = indexPath.section == 0 ? names[indexPath.row] : cNames[indexPath.row]
        
        let name = twoDimensionalArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = name
        
        if showIndexPaths {
            cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell
    }

}

