//
//  CreateGoalVC.swift
//  AchiveGoals
//
//  Created by Ahmed SR on 7/21/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController , UITextViewDelegate{
   //outlets
    @IBOutlet weak var goalTextView: UITextView!
   
    @IBOutlet weak var shortTermBtn: UIButton!
    
    @IBOutlet weak var longTermBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    //var
    var goalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
        nextBtn.bindToKeyboard()
        longTermBtn.setDeselectedColor()
        shortTermBtn.setSelectedColor()
    }
    
    //Action
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectedColor()
        longTermBtn.setSelectedColor()
        
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your Goal ?" {
            guard let finalGoalVC = storyboard?.instantiateViewController(withIdentifier: FINAL_GOAL_VC) as? FinalGoalVC else {
                return
            }
            finalGoalVC.initData(description: goalTextView.text!, goalType: goalType)
           presentingViewController?.presentSecanderyDetial(finalGoalVC)
            
        }
     
        
        
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetial()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
