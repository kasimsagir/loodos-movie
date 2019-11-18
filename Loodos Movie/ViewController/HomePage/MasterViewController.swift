//
//  MasterViewController.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var searchbar: UISearchBar!

    private var movies: [Movie] = [] {
        didSet {
            if movies.count == 0 {
                if searchText == "" {
                    DispatchQueue.main.async {
                        self.tableView.showTableViewEmptyLabel(message: "Enter a movie name.", containerView: self.tableView)
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self.tableView.hideTableViewEmptyMessage()
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var page = 1
    private var isNewDataLoading = false
    private var isEnd = false
    private var searchText: String = "" {
        didSet {
            page = 1
            isNewDataLoading = false
            isEnd = false
            NetworkManager.shared.router.cancel()
            getMovies(searchText, page)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        DispatchQueue.main.async {
            self.searchbar.becomeFirstResponder()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: Service
    func getMovies(_ query: String, _ page: Int) {
        if !isEnd {
            NetworkManager.shared.getMovies(query: query, page: page) { (moviesResponse, isEnd, responseError, error) in
                if let responseError = responseError {
                    DispatchQueue.main.async {
                        self.tableView.showTableViewEmptyLabel(message: responseError, containerView: self.tableView)
                    }
                }
                if page == 1 {
                    self.movies = moviesResponse ?? []
                }else {
                    self.movies.append(contentsOf: moviesResponse ?? [])
                }
                self.isEnd = isEnd
                self.isNewDataLoading = false
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let movie = movies[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.movieId = movie.imdbID
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.setUI(movie)

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+Constant.lazyLoadingBeforeCellCount >= movies.count {
            if !isNewDataLoading{
                isNewDataLoading = true
                page = page+1
                getMovies(searchText, page)
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MasterViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}
