//
//  GoalCell.swift
//  AchiveGoals
//
//  Created by Ahmed SR on 7/20/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
 //outlets
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var completeLabel: UILabel!
    //
//    func configureCell(description:String , type:String ,goalProgressAmount:Int){
//        self.goalDescriptionLbl.text = description
//        self.goalTypeLbl.text = type
//        self.goalProgressLbl.text = String(describing: goalProgressAmount) //String(describing:goalProgressAmount)
//    }
    
//    func configureCell(description:String , type:GoalType ,goalProgressAmount:Int){
//        self.goalDescriptionLbl.text = description
//        self.goalTypeLbl.text = type.rawValue
//        self.goalProgressLbl.text = String(describing: goalProgressAmount) //String(describing:goalProgressAmount)
//    }
    func configureCell(goal:Goals){
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress) //String(describing:goalProgressAmount)
        if goal.goalProgress == goal.goalCompletionValue {
            self.completeView.isHidden = false
            self.completeLabel.isHidden = false
        }else{
            self.completeView.isHidden = true
            self.completeLabel.isHidden = true
        }
    }
}
