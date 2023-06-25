//
//  MealTableViewCell.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/25/23.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    var model: MealViewModel!
    
    let mealLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        mealLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mealLabel)
        NSLayoutConstraint.activate([
            mealLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mealLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mealLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: MealViewModel) {
        self.model = model
        mealLabel.text = model.mealName
    }
    
}
