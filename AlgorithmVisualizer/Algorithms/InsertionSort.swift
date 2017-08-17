//
//  InsertionSort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class InsertionSort: AlgorithmProtocol {
    var parent: VisualizerView!
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []
    var numOfSwaps = 0

    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        let n = arr.count
        self.parent = parent
        self.originalArr = arr
        
        var i = 1
        while i < n {
            var j = i
            self.steps.append([false, i])
            
            while j > 0 && arr[j-1] > arr[j] {
                self.swap(index1: j, index2: j-1, arr: &arr)
                self.steps.append([true, j, j-1])
                self.steps.append([false, j])
                j -= 1
            }
            
            i += 1
        }
        
        self.steps.append([false, -1])
        self.parent.stopSort()
        self.animate(0)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                    self.animate(index + 1)
                })
            }
        }
    }
}





//func startSort(on arr: inout [CGFloat]) {
//    let n = arr.count
//    var i = 1
//
//    while i < n {
//        var j = i
//        while j > 0 && arr[j-1] > arr[j] {
//            self.swap(index1: j, index2: j-1, arr: &arr)
//            j -= 1
//        }
//        
//        i += 1
//    }
//}
//
//func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//    let temp = arr[index1]
//    arr[index1] = arr[index2]
//    arr[index2] = temp
//}

