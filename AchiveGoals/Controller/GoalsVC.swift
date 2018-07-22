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
        fetch { (complete) in
            if complete{
                if goals.count >= 1 {
                    goalTableView.isHidden = false
                }else{
                    goalTableView.isHidden = true
                }
            }
        }
        goalTableView.reloadData()
 
    }
    
    //Action
    @IBAction func addGoalBtnWasPreesed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: CREATE_GOAL_VC) else {
            return
        }
        presentDetail(createGoalVC)
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
    
    //
//    func numberOfSections(in tableView: UITableView) -> Int {
//      return  1
//    }
    
}
extension GoalsVC {
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

