//
//  UIImageView+URL.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/26/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageFromURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
