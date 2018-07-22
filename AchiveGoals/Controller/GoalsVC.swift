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
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.delegate = self
        goalTableView.dataSource = self
        // let goal = Goals()
        //goal.goalCompletionValue = 12.0 >> Error
      //  goal.goalCompletionValue = Int32(exactly: 12.0)! >> Right
    }
    
    //Action
    @IBAction func addGoalBtnWasPreesed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: CREATE_GOAL_VC) else {
            return
        }
        presentDetail(createGoalVC)
    }
    

}

// extensions
extension GoalsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GOAL_CELL) as? GoalCell else {
            return UITableViewCell()
        }
        cell.configureCell(description: "Eat salad twice a week .", type: GoalType.shortTerm, goalProgressAmount: 10)
       return cell
    }
    
    //
//    func numberOfSections(in tableView: UITableView) -> Int {
//      return  1
//    }
    
}

