//
//  CatagoryTableViewController.swift
//  DemoToDoList
//
//  Created by Meenakshi Phadatare on 10/20/21.
//

import UIKit
import CoreData




class CatagoryTableViewController: UITableViewController , ListCountDelegate{
    func numberofItemInList(count: Int) {
       
    }
    
   
  
    var viewModel = CategoryListViewModel(context:(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    var queue : OperationQueue = OperationQueue()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        self.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        viewModel.loadcategoryArray()
        self.tableView.reloadData()
        
    }
    
    func aaa(closurename: (String) -> Void) {
        print("sucess")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.lblTitle.text =  self.viewModel.categoryArray[indexPath.row].name

            // cell.textLabel?.text = self.viewModel.categoryArray[indexPath.row].name
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBorad = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard?.instantiateViewController(identifier: "ToDoListViewController") as! ToDoListViewController
        viewcontroller.delegate = self
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75.0
    }
    @IBAction func CategoryAddButtonClicked(_ sender: UIBarButtonItem) {
        
        let  alert = UIAlertController(title: "do-list", message: "", preferredStyle: .alert)
        
        var alertTxtField : UITextField?
        
        alert.addTextField { (TextField) in
            
            TextField.placeholder = "Enter the do list"
            alertTxtField = TextField
            
        }
        let action1 = UIAlertAction(title: "add item", style: .default) { (action) in
            
            guard let alertTxtField = alertTxtField , alertTxtField.text!.count > 0 else{
                return
            }
    
            
            self.viewModel.saveCategory(Item: alertTxtField.text!)
            self.viewModel.loadcategoryArray()
            
            self.tableView.reloadData()
            
            
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        
        present(alert, animated: true, completion: nil)
        
        
       
   
    }
    
    
    
    
    
  
    
}

