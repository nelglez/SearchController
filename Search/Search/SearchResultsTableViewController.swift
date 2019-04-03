//
//  SearchResultsTableViewController.swift
//  Search
//
//  Created by Spencer Curtis on 4/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredDataSource = dataSource
        
       
        
        //filter search results in this same VC by passing in nil
        searchController = UISearchController(searchResultsController: nil)
        //Configure the look of search controller
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    //gets called for every character entered in search bar.
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text else {return}
        
        if searchTerm.isEmpty {
            filteredDataSource = dataSource
        } else {
        filteredDataSource = dataSource.filter({$0.lowercased().contains(searchTerm.lowercased())})
        }
        //updated the dataSource, go set up the new cells.
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SomeCell", for: indexPath)

        cell.textLabel?.text = filteredDataSource[indexPath.row]

        return cell
    }

    var dataSource = ["foo", "bar", "baz", "foz", "moo"]
    var filteredDataSource: [String] = []
    
    var searchController: UISearchController!
    @IBOutlet weak var searchBar: UISearchBar!
}
