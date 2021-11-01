//
//  ViewController.swift
//  DemoToDoList
//
//  Created by Meenakshi Phadatare on 10/14/21.
//

import UIKit
import CoreData


protocol ListCountDelegate {
    
    func numberofItemInList(count : Int)
}

class ToDoListViewController: UITableViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var delegate : ListCountDelegate!
    
   
    var toDoListModelView = ToDoListViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    let userdefaults = UserDefaults.standard

    let datafilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.toDoListModelView.loadItems()
        self.tableView.reloadData()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    
       
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        cell.textLabel?.text = self.toDoListModelView.todoArray[indexPath.row].name
        let isSelected = self.toDoListModelView.todoArray[indexPath.row].ischecked
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoListModelView.todoArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let isSelected = self.toDoListModelView.todoArray[indexPath.row].ischecked
        tableView.cellForRow(at: indexPath)?.accessoryType = isSelected ? .none : .checkmark
        self.toDoListModelView.todoArray[indexPath.row].ischecked = !isSelected
       
        tableView.deselectRow(at: indexPath, animated: false)
        self.toDoListModelView.loadItems();
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
        
          
            self.toDoListModelView.deleteItemFromTodolist(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.numberofItemInList(count: self.toDoListModelView.todoArray.count)
    }
    
    @IBAction func addItemButtonClicked(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Item to todoey", message: "", preferredStyle: .alert)
        var textfield : UITextField?
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "create a item"
            textfield = alertTextfield
        }
        let action  = UIAlertAction(title: "Add item", style: .default) { (action) in
            guard let textfield = textfield ,textfield.text?.count == 0 else{
                return
            }
            
          
            
            self.toDoListModelView.addItem(name: textfield.text!, with: false)
            self.toDoListModelView.loadItems()
            self.tableView.reloadData()
            
        }
        let action2 = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
        
    }
    
/*
    func saveItems()  {

        do{
             try context.save()
        }
        catch{
            print("Enable to save in database =\(error)")
        }
        
        
        tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<TodoList> =  TodoList.fetchRequest())  {
        
        
        do{
            self.todoArray = try context.fetch(request)
            
        }catch{
            print("Enable to  fetch = \(Error.self)")
            
        }
        tableView.reloadData()
    
    }
    */
    
    
}
    
extension ToDoListViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.toDoListModelView.searchTodoListItem(name: searchBar.text!)
        self.tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text?.count == 0 {
            
            self.toDoListModelView.loadItems()
            self.tableView.reloadData()
        }
        
        searchBar.resignFirstResponder()
    
    }
    
}


