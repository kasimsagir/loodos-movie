//
//  DetailViewController.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UITableViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kindOfMovieLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!

    private var movieDetail: MovieDetail? {
        didSet{
            setUI()
            Analytics.logEvent("movieDetail", parameters: try! movieDetail?.asDictionary())
        }
    }
    var movieId: String? {
        didSet{
            getDetails(movieId ?? "")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Set UI
    func setUI(){

        DispatchQueue.main.async {
            self.backPoster.kf.setImage(with: URL(string: self.movieDetail?.poster ?? ""), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            self.posterImage.kf.setImage(with: URL(string: self.movieDetail?.poster ?? ""), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)

            self.kindOfMovieLabel.text = self.movieDetail?.genre ?? ""
            self.descriptionLabel.text = self.movieDetail?.plot ?? ""
            self.titleLabel.text = self.movieDetail?.title
            self.rateLabel.text = self.movieDetail?.ratings?.first?.value ?? ""
            self.castLabel.text = self.movieDetail?.actors
        }
    }

    // MARK: Service
    func getDetails(_ movieId : String) {
        NetworkManager.shared.getMovieDetail(movieId: movieId) { (movieDetailResponse, error) in
            if error != nil {
                self.showAlert(title: "Error", message: error)
            }
            self.movieDetail = movieDetailResponse
        }
    }

}
