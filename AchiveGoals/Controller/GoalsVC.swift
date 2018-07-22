//
//  ViewController.swift
//  AchiveGoals
//
//  Created by Ahmed SR on 7/20/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    //outlets
    @IBOutlet weak var goalTableView: UITableView!
  
  
    //var
    var goals :[Goals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.delegate = self
        goalTableView.dataSource = self
        // let goal = Goals()
        //goal.goalCompletionValue = 12.0 >> Error
      //  goal.goalCompletionValue = Int32(exactly: 12.0)! >> Right
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         fetchCoreDataObjects()
         goalTableView.reloadData()
    }
    
    //Action
    @IBAction func addGoalBtnWasPreesed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: CREATE_GOAL_VC) else {
            return
        }
        presentDetail(createGoalVC)
    }
    
    
    //Functions
    func fetchCoreDataObjects(){
        fetch { (complete) in
            if complete{
                if goals.count >= 1 {
                    goalTableView.isHidden = false
                }else{
                    goalTableView.isHidden = true
                }
            }
        }
        
    }
    

}

// extensions Tabel View
extension GoalsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let indexElement = goals[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GOAL_CELL) as? GoalCell else {
            return UITableViewCell()
        }
    
//        cell.configureCell(description: indexElement.description, type: GoalType(rawValue: indexElement.goalType!)!, goalProgressAmount: Int(indexElement.goalCompletionValue))
         cell.configureCell(goal: indexElement)
        
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeData(indexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD") { (rowAction, indexpath) in
            self.setProgress(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deletAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.5683326199)
        return [deletAction,addAction]
        
    }
    
    
    //
//    func numberOfSections(in tableView: UITableView) -> Int {
//      return  1
//    }
    
}
extension GoalsVC {
    //
    func setProgress(indexPath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return
        }
        let chosenGoal = goals[indexPath.row]
        // init = 0              like : 8
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else{
            return
        }
        do {
            try managedContext.save()
            print("Successfully set progress!")
        }catch{
            debugPrint("Could not set progress : \(error.localizedDescription )")
        }
    }
    
    // Remove row from CoreData Array like goals
    func removeData(indexPath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed Goal !")
        }catch{
            debugPrint("Could not remove \(error.localizedDescription) ")
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //Get Data From Core Data
    func fetch(completion:(_ complete:Bool)->()){
        guard  let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        // get data from persistent Storg
        let fetchRequest = NSFetchRequest<Goals>(entityName: "Goals")
        do {
           goals =  try managedContext.fetch(fetchRequest)
            print("Successfully fetch Data")
            completion(true)
        }catch{
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

