//
//  FinalGoalVC.swift
//  AchiveGoals
//
//  Created by Ahmed SR on 7/22/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import CoreData

class FinalGoalVC: UIViewController {
    //outlets
    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    //var
    var goalDescription:String?
    var goalType:GoalType?
    
    //Function
    func initData(description:String , goalType:GoalType){
        self.goalDescription = description
        self.goalType = goalType
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
       // print(goalDescription,goalType)
        
    }

    //Actions
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetial()
    }
    
    @IBAction func createGoalWasPressed(_ sender: Any) {
        //Core ML Data
        if pointTextField.text! != "" {
            self.save { (complte) in
                if complte {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    // (complition:(_ finished:Bool)-())
    func save(complition:(_ finished:Bool)->()){
        // manageedContext
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return
        }
        //GoalContext
        let goal = Goals(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalCompletionValue = Int32(pointTextField.text!)!
        goal.goalProgress = Int32(0)
        goal.goalType = goalType?.rawValue
        do {
           try managedContext.save()
            complition(true)
            print(" Successfully saved Data .. ")
        }catch{
            debugPrint("Could not save : \(error.localizedDescription)")
            complition(false)
        }
        
        
        
    }
    
    
    
    
    
    
    
}
