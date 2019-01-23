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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
//        let newItem = Item()
//        newItem.title = "Find Love"
//        itemArray.append(newItem)
//        
//        let newItem1 = Item()
//        newItem1.title = "Make love"
//        itemArray.append(newItem1)
//        
//        let newItem2 = Item()
//        newItem2.title = "Fill Heart with love"
//        itemArray.append(newItem2)
        
        loadItems()
        
//        if let  items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//
//        }
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
        
          saveItems()
        
//        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add new todoey list here", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
           
            let newItem = Item()
            newItem.title  = textfield.text!
            
            self.itemArray.append(newItem)
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()

        
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
           
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
//   MARK -  MODEL MANUPULATION METHOD
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to : dataFilePath!)
        }catch {
            print("Error encoding item array ,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf : dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array , \(error)")
            }
        }
    }
}

