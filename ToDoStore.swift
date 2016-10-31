 //
 //  ToDoStore.swift
 //  ToDoAppAnderson
 //
 //  Created by Melissa Anderson on 10/19/16.
 //  Copyright © 2016 Melissa Anderson. All rights reserved.
 //
 
 import UIKit
 
 
 
 
 class ToDoStore{
    static let shared = ToDoStore()
    
    fileprivate var toDos: [[ToDo]]!
    // only do this for one image.
    var selectedImage: UIImage?
    
    // this init lets us read from the file.
    init(){
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        
        if fileManager.fileExists (atPath:filePath) {
            toDos = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as!
                [[ToDo]]
        }else {
            toDos = [[],[],[]]
            toDos[0].append(ToDo(title: "ToDo 1", category: 0, dueDate: Date(), completion: false, priority: 0.0))
            toDos[1].append(ToDo(title: "ToDo 2", category: 1, dueDate: Date(), completion: false, priority: 0.0))
            toDos[2].append(ToDo(title: "ToDo 3", category: 2, dueDate: Date(), completion: false, priority: 0.0))

            
            save() }
        sort()
    }
    
    // add three to do items that starts on the first run (prepopulated)
    
    //MARK: - Public functions
    // mark adds todo at the top
    
    // add 5 func add, get, save, delete, how many todo
    func getToDo(_ index: Int, category: Int) -> ToDo {
        return toDos[category][index]
    }
    func addToDo(_ ToDo: ToDo, category: Int){
        toDos[category].insert(ToDo, at:0 )
        
    }
    func deleteToDo(_ index: Int, category:Int){
        toDos[category].remove(at: index)
    }
    func getCount(category: Int) -> Int {
        return toDos[category].count
    }
    
    func getPriority(category: Int) -> Double{
        var priority = 0.0
        for todo in toDos[category]{
            priority = max(priority, todo.priority)
        }
        return priority + 1.0
    }
    // lets us save this in one line of code
    
    func save(){
        NSKeyedArchiver.archiveRootObject(toDos, toFile: archiveFilePath())
    }
    
    // sorts the toDos based on the date.. weither or not it is the newest.
    func sort(){
        //     toDos.sort { (ToDo1, ToDo2 ) -> Bool in
        //          return ToDo1.date.compare(ToDo2.date) == .orderedDescending
        //     }
        /// can use this also to SORT :  toDos.sort { $0.date.compare($1.date) ==orderedDecending
    }
    
    
    //MARK: -Private functions
    
    // tells the file we are reading and writing from for our todos.  this is to save the todos when the app goes to the background
    
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        
        let documentDirectory = paths.first!
        let path = (documentDirectory as NSString).appendingPathComponent("ToDoStore.plist")
        return path
    }
 }
 
 
 
 
 
 
 
 
 
 
