//
//  MovieCell.swift
//  Loodos Movie
//
//  Created by Kasım on 18.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {

    }

    func setUI(_ movie: Movie){
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: URL(string: movie.poster ?? ""), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.year
            self.dateLabel.text = ""
        }
    }
}
