//
//  CategoryListViewModel.swift
//  DemoToDoList
//
//  Created by Meenakshi Phadatare on 10/27/21.
//

import Foundation
import CoreData
class CategoryListViewModel {
    var categoryArray : [Category] = []
    var context: NSManagedObjectContext
    
    
    init(context : NSManagedObjectContext) {
        self.context = context
    }
    
    func loadcategoryArray(with request:NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            self.categoryArray = try self.context.fetch(request)
        }
        catch{
            print("unable to fetch : \(Error.self)")
            
        }
       
    }
    
    
    func saveCategory(Item name : String)  {
        do{
            
            let item = Category(context: self.context)
            item.name = name
            try context.save()
            
        }
        catch{
            print("unable to save : \(Error.self)")
        }
        
    }
   
    
}
