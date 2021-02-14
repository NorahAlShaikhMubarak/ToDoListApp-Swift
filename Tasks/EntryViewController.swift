//
//  EntryViewController.swift
//  Tasks
//
//  Created by Norah Alshaikhmubarak  on 2/13/21.
//  Copyright © 2021 Norah Alshaikhmubarak . All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        //creating the save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveTask))

        // Do any additional setup after loading the view.
    }
    //function called once the person
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //function called onec the user hits the return key on the keyboard
        
        saveTask()
        return true
    }
    //objc allows this function to be used as a selector
    @objc func saveTask(){
        
        //checking if the text is not empty
        guard let text = field.text, !text.isEmpty else {
            return 
        }
        //save the task we entered in the text
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")
        //if this update function exists , call it.
        update?()
        navigationController?.popViewController(animated: true)

    }

}
