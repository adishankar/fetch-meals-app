//
//  MealTableViewCell.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/25/23.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    var model: MealViewModel!
    
    let mealThumbnail: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let mealLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        mealThumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mealThumbnail)
        NSLayoutConstraint.activate([
            mealThumbnail.widthAnchor.constraint(equalToConstant: 50),
            mealThumbnail.heightAnchor.constraint(equalToConstant: 50),
            mealThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mealThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mealThumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
        
        mealLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mealLabel)
        NSLayoutConstraint.activate([
            mealLabel.leadingAnchor.constraint(equalTo: mealThumbnail.trailingAnchor, constant: 10),
            mealLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mealLabel.centerYAnchor.constraint(equalTo: mealThumbnail.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: MealViewModel) {
        self.model = model
        mealLabel.text = model.mealName
        mealThumbnail.imageFromURL(model.thumbnailUrl)
    }
    
}
