//
//  ViewController.swift
//  Tasks
//
//  Created by Norah Alshaikhmubarak  on 2/13/21.
//  Copyright © 2021 Norah Alshaikhmubarak . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //lets us control the tableview on the storyboard that we added by conneting "tableview" variable to it
    @IBOutlet var tableView: UITableView!
    //array to hold the tasks that user entered so far
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup block to make sure we start off with a count of zero
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        //Get all current saved tasks
        updateTasks()
        
    }
    
    func updateTasks(){
        //to prevent duplicates
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0..<count{
            
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        //refresh tableview after adding a task
        tableView.reloadData()
    }
    //IBAction means it's connected to the storyboard
    @IBAction func fundidTapAdd(){
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            //updating tasks
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
//what happens when we select a cell
extension ViewController: UITableViewDelegate {
    //select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //de select a row to get rid of the highlight color
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        //get the selected task clicked
        vc.task = tasks[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//datasource supplies data and handels interactions with the cells on the table view
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    //return the cell of a given row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //DQ a cell which means using the template over to get an instence of a cell (reuse cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //index path row represents the position of the cell in the table view
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
