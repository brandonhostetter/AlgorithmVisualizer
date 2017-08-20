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

    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        var n = arr.count
        self.parent = parent
        self.originalArr = arr
        
        repeat {
            var newEnd = 0
            
            for i in 1..<n {
                self.steps.append([false, i - 1])
                if arr[i - 1] > arr[i] {
                    self.swap(index1: i - 1, index2: i, arr: &arr)
                    self.steps.append([true, i - 1, i])
                    newEnd = i
                }
            }
            
            n = newEnd
        } while n != 0
        
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









// Slightly improved version that doesn't compare elements to already sorted portions
//func startSort(on arr: inout [CGFloat]) {
//    var n = arr.count
//
//    repeat {
//        var newEnd = 0
//        
//        for i in 1..<n {
//            if arr[i - 1] > arr[i] {
//                self.swap(index1: i - 1, index2: i, arr: &arr)
//                newEnd = i
//            }
//        }
//        
//        n = newEnd
//    } while n != 0
//}
//
//func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//    let temp = arr[index1]
//    arr[index1] = arr[index2]
//    arr[index2] = temp
//}
    
