//
//  TaskViewController.swift
//  Tasks
//
//  Created by Norah Alshaikhmubarak  on 2/13/21.
//  Copyright © 2021 Norah Alshaikhmubarak . All rights reserved.
//

import UIKit
//info about a given task
class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    var task: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        //Create delete button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(){
        
     //   let newCount = count - 1
        
      //  UserDefaults.setValue(newCount, forKey: "count")
      //  UserDefaults.setValue(nil, forKey: "task_\(currentPosition)")

    }
    

}
