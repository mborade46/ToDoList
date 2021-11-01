//
//  DatabaseOperationManager .swift
//  DemoToDoList
//
//  Created by Meenakshi Phadatare on 10/27/21.
//

import Foundation
import CoreData

class ToDoListViewModel {
    var context: NSManagedObjectContext
    var todoArray : [TodoList] = []
    

    init(context: NSManagedObjectContext) {
        self.context = context
        
    }
    
    
    func saveItems()  {

        do{
             try context.save()
        }
        catch{
            print("Enable to save in database =\(error)")
        }
        
    }
    
    func addItem(name : String , with isdone:Bool)  {

        do{
            
            let todoItem = TodoList(context: self.context)
            todoItem.name = name
            todoItem.ischecked = isdone
            
             try context.save()
        }
        catch{
            print("Enable to save in database =\(error)")
        }
        
    }
    
    func loadItems(with request : NSFetchRequest<TodoList> =  TodoList.fetchRequest())  {
        
        
        do{
            self.todoArray = try context.fetch(request)
            
        }catch{
            print("Enable to  fetch = \(Error.self)")
            
        }
      
    
    }
    
    func getItemString() -> String {
        "This is stored item"
    }
    
    
    func searchTodoListItem(name : String) {
        
        let request : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.sortDescriptors  = [NSSortDescriptor(key: "name", ascending: true)]
        self.loadItems(with: request)
        
    }
    
    func deleteTodolistItems(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoList")

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
 
        do {
            try self.context.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
    }
    func deleteItemFromTodolist(index : Int){

            
        self.context.delete(self.todoArray[index])
        self.todoArray.remove(at: index)
        self.saveItems()
    
    }
    
}



