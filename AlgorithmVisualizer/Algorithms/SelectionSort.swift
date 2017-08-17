//
//  SelectionSort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class SelectionSort: AlgorithmProtocol {
    var parent: VisualizerView!
    var numOfSwaps = 0
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []
    
    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        let n = arr.count
        self.parent = parent
        self.originalArr = arr
        
        for j in 0..<n {
            var min = j
            for i in j+1..<n {
                if arr[i] < arr[min] {
                    min = i
                }
                
                self.steps.append([false, i])
            }
            
            if min != j {
                self.swap(index1: j, index2: min, arr: &arr)
                self.steps.append([true, j, min])
                numOfSwaps += 1
            }
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                    self.animate(index + 1)
                })
            }
        }
    }
}




//class SelectionSort {
//    func startSort(on arr: inout [CGFloat]) {
//        let n = arr.count
//        
//        for j in 0..<n {
//            var min = j
//            for i in j+1..<n {
//                if arr[i] < arr[min] {
//                    min = i
//                }
//            }
//            
//            if min != j {
//                self.swap(index1: j, index2: min, arr: &arr)
//            }
//        }
//    }
//    
//    func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//        let temp = arr[index1]
//        arr[index1] = arr[index2]
//        arr[index2] = temp
//    }
//}

