//
//  DetailViewController.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailItem: String? {
        didSet {
            self.configureView()
        }
    }
    
    @IBOutlet weak var startButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    func configureView() {
        if let detail = self.detailItem {
            if let visualizerView = self.view.subviews.first as? VisualizerView {
                visualizerView.algorithmType = detail
                visualizerView.setNeedsDisplay()
            }
        }
    }
    
    @IBAction func startVisualizer(_ sender: Any) {
        if let detail = self.detailItem {
            if let visualizerView = self.view.subviews.first as? VisualizerView {
                visualizerView.startSort(detail)
            }
        }
    }
}

