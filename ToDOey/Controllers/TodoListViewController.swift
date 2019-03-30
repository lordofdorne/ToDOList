//
//  ViewController.swift
//  ToDOey
//
//  Created by Asim on 3/22/19.
//  Copyright © 2019 Asim Samuel. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
      let newItem = Item()
        newItem.title =  "Practice Code"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title =  "Practice Code"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title =  "Practice Code"
        itemArray.append(newItem3)
        
        
        
        

//
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDOItemCell", for: indexPath)
        
        // Configure the cell’s contents.
        let item = itemArray[indexPath.row]
        
        cell.textLabel!.text = item.title
        cell.accessoryType = item.done  ? .checkmark : .none
        
      
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
     
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done


        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks the Add button on UIAlert
            
           let newItem = Item()
            newItem.title = textField.text!
           
            self.itemArray.append(newItem)
            
            self.saveItems()
           
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode( [Item].self, from: data)
                } catch {
                print("Error decoding item, \(error) ")
                }
        }
    }

}

