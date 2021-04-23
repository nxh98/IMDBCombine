//
//  ImageViewExt.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
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
