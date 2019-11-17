//
//  DetailViewController.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    private var movieDetail: MovieDetail? {
        didSet{
            //setUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }



}

