//
//  Heapsort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class Heapsort: AlgorithmProtocol {
    var parent: VisualizerView!
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []

    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        let n = arr.count
        self.parent = parent
        self.originalArr = arr

        self.heapify(&arr, n)
        
        var end = n - 1
        while end > 0 {
            self.swap(index1: end, index2: 0, arr: &arr)
            end = end - 1
            self.siftDown(&arr, 0, end)
        }
        
        self.parent.update(numbers: arr)
    }
    
    func heapify(_ arr: inout [CGFloat], _ count: Int) {
        var start: Int = (count - 2) / 2
        
        while start >= 0 {
            self.siftDown(&arr, start, count - 1)
            start -= 1
        }
    }
    
    func siftDown(_ arr: inout [CGFloat], _ start: Int, _ end: Int) {
        var root = start
        
        while root * 2 + 1 <= end {
            var child = root * 2 + 1
            if child + 1 <= end && arr[child] < arr[child + 1] {
                child += 1
            }
            if arr[root] < arr[child] {
                self.swap(index1: root, index2: child, arr: &arr)
                root = child
            } else {
                return
            }
        }
    }
    
    func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
        let temp = arr[index1]
        arr[index1] = arr[index2]
        arr[index2] = temp
    }
}






















