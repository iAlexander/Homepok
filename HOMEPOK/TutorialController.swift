//
//  TutorialController.swift
//  HOMEPOK
//
//  Created by Alexander Iashchuk on 11/21/16.
//  Copyright © 2015 Alexander Iashchuk. All rights reserved.
//

import UIKit

class TutorialController: UIViewController {
    
    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var tutorialSteps = 0
    var tutorialLaunchCount: Double = 0
    let numberOfTutorialLaunchesKey = "numberOfTutorialLaunches"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialLaunchCount = defaults.double(forKey: numberOfTutorialLaunchesKey)
        finishButton.isHidden = true
        if tutorialLaunchCount == 0 {
            tutorialLaunchCount += 1
            defaults.set(tutorialLaunchCount, forKey: numberOfTutorialLaunchesKey)
            topTextLabel.text = localizedTextOutput("t01")
            bottomTextLabel.text = localizedTextOutput("t02")
            print("Tutorial Launch Count: \(tutorialLaunchCount)")
        } else {
            tutorialLaunchCount += 1
            defaults.set(tutorialLaunchCount, forKey: numberOfTutorialLaunchesKey)
            tutorialSteps += 1
            tutorialImageView.image = UIImage(named: "Tutorial1")
            topTextLabel.text = localizedTextOutput("t11")
            bottomTextLabel.text = localizedTextOutput("t12")
            print("Tutorial Launch Count: \(tutorialLaunchCount)")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    @IBAction func nextButton(_ sender: Any) {
        tutorialSteps += 1
        if tutorialSteps == 1 {
            tutorialImageView.image = UIImage(named: "Tutorial1")
            topTextLabel.text = localizedTextOutput("t11")
            bottomTextLabel.text = localizedTextOutput("t12")
        } else if tutorialSteps == 2 {
            tutorialImageView.image = UIImage(named: "Tutorial2")
            topTextLabel.text = localizedTextOutput("t21")
            bottomTextLabel.text = localizedTextOutput("t22")
        } else if tutorialSteps == 3 {
            tutorialImageView.image = UIImage(named: "Tutorial3")
            topTextLabel.text = localizedTextOutput("t31")
            bottomTextLabel.text = localizedTextOutput("t32")
            tutorialButton.isHidden = true
            finishButton.isHidden = false
        }
    }
    
    func localizedTextOutput (_ key: String) -> String {
        let path = Bundle.main.path(forResource: "LocalizedStrings", ofType: "plist")
        let localizedDict = NSDictionary(contentsOfFile: path!) as? [String: String]
        let result = localizedDict![key]! as String
        return result
    }
    
}
