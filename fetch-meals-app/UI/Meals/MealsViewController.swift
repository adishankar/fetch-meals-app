//
//  MealsViewController.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/23/23.
//

import UIKit
import SwiftUI

class MealsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        let hostingController = UIHostingController(rootView: MealsView())
        addChild(hostingController)
        let mealsView = hostingController.view!
        mealsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mealsView)
        hostingController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            mealsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mealsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mealsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mealsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }


}

