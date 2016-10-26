//
//  ToDosTableViewController.swift
//  ToDoTakingAppAnderson
//
//  Created by Melissa Anderson on 10/18/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit

class ToDosTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Table view data source
    // example contacts each section.. a, b, c.. the person name is a row.   we want a row for each toDo
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    //  override func sectionIndexTitles(for tableView: UITableView) -> [String]?{
    //   return
    //   }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoStore.shared.getCount(category: section)
    }
    
    // Mark: - switch for the section on the table view.
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Home To Do List"
        case 1:
            return "Work To Do List"
        case 2:
            return "Misc To Do List"
        default:
            return "Section does not exist"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoTableViewCell.self)) as! ToDoTableViewCell
        
        cell.setupCell(ToDoStore.shared.getToDo(indexPath.row, category: indexPath.section))
        
        // Configure the cell...
        
        return cell
    }
    //MARK: - ADDING THE ABILITY TO MAKE CELLS REORDERABLE
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ToDoStore.shared.deleteToDo(indexPath.row, category: indexPath.section)  //  deletes rows in toDos as needed !!! AWESOME
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Rearrange the table view.  use first.
    /*
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
    }
   
    // Override to support rearranging the table view.  use next
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = self.toDos.category
     if indexPath >= 0 { move to indexPath 0
     }else if indexPath <= 2 { move to indexPath
     }else if indexPath = (#) { indexPath (#) + indexPath (#) / 2
     return
     
    }
    either moved to top .. bottom or somewhere in the middle if top make sure it has lower prio // if index path is 0 .. move to top - 1..
    */
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /// this lets us connect the seque so that we can edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToDoSegue" {
            let toDoDetailVC = segue.destination as! ToDoDetailViewController
            let tableCell = sender as! ToDoTableViewCell
            toDoDetailVC.toDo = tableCell.toDo
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    
    //MARK: unwind Segue   ---  this lets us edit the toDos// else adds another toDo so user can add as many toDos  as possible
    
    @IBAction func saveToDoDetail(_ segue: UIStoryboardSegue){
        let toDoDetailVC = segue.source as! ToDoDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            ToDoStore.shared.sort()
            
            var indexPaths: [IndexPath] = []
            for index in 0...indexPath.row {
                indexPaths.append(IndexPath(row: index, section: 0))
                
            }
            
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }else{
            toDoDetailVC.toDo.priority = ToDoStore.shared.getPriority(category: toDoDetailVC.toDo.category)
            ToDoStore.shared.addToDo(toDoDetailVC.toDo, category: toDoDetailVC.toDo.category)
            let indexPath = IndexPath(row: 0, section: toDoDetailVC.toDo.category)
            tableView.insertRows(at: [indexPath], with: .automatic)// several options available automatic - when upgrades are made the style will be changed to defaults to other systems.
            
            
        }
        
        
        
    }
    
}





