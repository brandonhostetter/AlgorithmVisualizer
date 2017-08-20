//
//  MasterViewController.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    
    
    //https://en.wikipedia.org/wiki/Sorting_algorithm#Related_algorithms
    
    
    var detailViewController: DetailViewController? = nil
    let algorithms = [
        [
            Algorithm.InsertionSort,
            Algorithm.SelectionSort
        ], [
            Algorithm.Heapsort,
            Algorithm.MergeSort,
            Algorithm.Quicksort
        ], [
            Algorithm.BubbleSort,
            Algorithm.CocktailSort,
            Algorithm.CombSort,
            Algorithm.ShellSort,
            Algorithm.SlowSort
        ], [
            Algorithm.BucketSort,
            Algorithm.CountingSort,
            Algorithm.RadixSort
        ]
    ]
    let sectionHeaders = [
        "Basic Sorts",
        "Efficient Sorts",
        "Bubble Sort and Variants",
        "Distribution Sorts"
    ]

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let algorithm = algorithms[indexPath.section][indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = algorithm["key"]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeaders[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algorithms[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let algorithm = algorithms[indexPath.section][indexPath.row]
        cell.textLabel!.text = algorithm["display"]
        return cell
    }
}

