//
//  BubbleSort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class BubbleSort: AlgorithmProtocol {
    var parent: VisualizerView!
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []
    var numOfSwaps = 0

    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        let n = arr.count
        var swapped = false
        self.parent = parent
        self.originalArr = arr
        
        repeat {
            swapped = false
            
            for i in 1..<n {
                self.steps.append([false, i])
                if arr[i - 1] > arr[i] {
                    self.swap(index1: i-1, index2: i, arr: &arr)
                    self.steps.append([true, i-1, i])
                    swapped = true
                    self.numOfSwaps += 1
                }
            }
        } while swapped == true
        
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




//class BubbleSort {
//    func startSort(on arr: inout [CGFloat]) {
//        let n = arr.count
//        var swapped = false
//        
//        repeat {
//            swapped = false
//            
//            for i in 1..<n {
//                if arr[i - 1] > arr[i] {
//                    self.swap(index1: i-1, index2: i, arr: &arr)
//                    swapped = true
//                }
//            }
//        } while swapped == true
//    }
//    
//    func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//        let temp = arr[index1]
//        arr[index1] = arr[index2]
//        arr[index2] = temp
//    }
//}

