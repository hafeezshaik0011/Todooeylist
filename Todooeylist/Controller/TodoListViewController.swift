//
//  ViewController.swift
//  Todooeylist
//
//  Created by apple on 1/20/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
        var itemArray = [Item]()
       var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Love"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Make love"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Fill Heart with love"
        itemArray.append(newItem2)
        
        if let  items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
// MARK - TABLEVIEW DATASOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        

        let item = itemArray[indexPath.row]
        
                cell.textLabel?.text = item.title
        
//        ternary operator
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        return cell
    }
//    MARK - TABLEVIEW DELEGATE METHOD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        
//        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//             tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add new todoey list here", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            print("success!")
            print(textfield.text)
            let newItem = Item()
            newItem.title  = textfield.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
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

