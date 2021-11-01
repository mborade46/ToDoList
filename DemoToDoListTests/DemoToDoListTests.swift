//
//  DemoToDoListTests.swift
//  DemoToDoListTests
//
//  Created by Meenakshi Phadatare on 10/29/21.
//

import XCTest
import CoreData
@testable import DemoToDoList

class DemoToDoListTests: XCTestCase {
    var todoListViewModel: ToDoListViewModel!
 
    override func setUpWithError() throws {
        todoListViewModel = ToDoListViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
    
    func testGetItemValueWhenItemsArePresent() throws {
        let itemStringValue = todoListViewModel.getItemString()
        XCTAssertEqual(itemStringValue, "This is stored item")
    }
    
    func testAddItemToToDoListStorage() throws {
        todoListViewModel.todoArray.removeAll()
        todoListViewModel.addItem(name: "Make Lunch", with: true)
        todoListViewModel.loadItems()
        let makeLunchItem = try XCTUnwrap(todoListViewModel.todoArray.first(where: {$0.name == "Make Lunch"}))
        XCTAssertEqual(makeLunchItem.name, "Make Lunch")
    }
    
    func testLoadItemsareZeroWhenNoitemsAdded() throws {

        todoListViewModel.deleteTodolistItems()
        todoListViewModel.loadItems()
       XCTAssertEqual(try? XCTUnwrap(todoListViewModel.todoArray.count), 0)
        
    }
    
  func testSearchtestItemsareZeroWhenItemNotPresent() throws {
   
     try? todoListViewModel.searchTodoListItem(name: "0000")
    let items = todoListViewModel.todoArray
    XCTAssertEqual(items.count, 0)
    
  }
    
}
