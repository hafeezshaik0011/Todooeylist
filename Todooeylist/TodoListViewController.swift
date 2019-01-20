//
//  ViewController.swift
//  Todooeylist
//
//  Created by apple on 1/20/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
        var itemArray = ["COMPLETE TASK","FIND JOB","GET SETTLED"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
// MARK - TABLEVIEW DATASOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
//    MARK - TABLEVIEW DELEGATE METHOD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add new todoey list here", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            print("success!")
            print(textfield.text)
            self.itemArray.append(textfield.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
           
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
}

