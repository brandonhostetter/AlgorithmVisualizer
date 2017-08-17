//
//  Quicksort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class QuickSort: AlgorithmProtocol {
    var parent: VisualizerView!
    var numOfSwaps = 0
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []

    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        let n = arr.count
        self.parent = parent
        self.originalArr = arr
        
        self.quicksort(&arr, 0, n - 1)

        self.steps.append([false, -1])
        self.parent.stopSort()
        self.animate(0)
    }
    
    func quicksort(_ arr: inout [CGFloat], _ low: Int, _ high: Int) {
        if low < high {
            let pivot = self.partition(&arr, low, high)
            quicksort(&arr, low, pivot - 1)
            quicksort(&arr, pivot + 1, high)
        }
    }
    
    func partition(_ arr: inout [CGFloat], _ low: Int, _ high: Int) -> Int {
        let pivot = arr[high]
        var i = low - 1
        
        for j in low..<high {
            self.steps.append([false, j])
            if arr[j] < pivot {
                i += 1
                self.swap(index1: i, index2: j, arr: &arr)
                self.steps.append([true, i, j])
            }
        }
        
        if arr[high] < arr[i + 1] {
            self.swap(index1: i + 1, index2: high, arr: &arr)
            self.steps.append([true, i + 1, high])
        }
        
        return i + 1
    }
    
    func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
        let temp = arr[index1]
        arr[index1] = arr[index2]
        arr[index2] = temp
    }
    
    func animate(_ index: Int) {
        if index < self.steps.count {
            if self.steps[index][0] as! Bool == true {
                self.swap(index1: self.steps[index][1] as! Int, index2: self.steps[index][2] as! Int, arr: &self.originalArr)
                self.animate(index + 1)
            } else {
                self.parent.update(numbers: self.originalArr, (self.steps[index][1] as! Int))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.animate(index + 1)
                })
            }
        }
    }
}






//func quicksort(_ arr: inout [CGFloat], _ low: Int, _ high: Int) {
//    if low < high {
//        let pivot = self.partition(&arr, low, high)
//        quicksort(&arr, low, pivot - 1)
//        quicksort(&arr, pivot + 1, high)
//    }
//}
//
//func partition(_ arr: inout [CGFloat], _ low: Int, _ high: Int) -> Int {
//    let pivot = arr[high]
//    var i = low - 1
//    
//    for j in low..<high {
//        if arr[j] < pivot {
//            i += 1
//            self.swap(index1: i, index2: j, arr: &arr)
//        }
//    }
//    
//    if arr[high] < arr[i + 1] {
//        self.swap(index1: i + 1, index2: high, arr: &arr)
//    }
//    
//    return i + 1
//}
//
//func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//    let temp = arr[index1]
//    arr[index1] = arr[index2]
//    arr[index2] = temp
//}

