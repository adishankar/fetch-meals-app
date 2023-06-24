//
//  ViewController.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var headerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.headerLabel = UILabel()
        headerLabel.font = .boldSystemFont(ofSize: 36)
        headerLabel.text = "Fetch Meals"
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(headerLabel)
        let headerLeadingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 20)
        let headerTopConstraint = NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 20)
        self.view.addConstraints([headerLeadingConstraint, headerTopConstraint])
    }


}

