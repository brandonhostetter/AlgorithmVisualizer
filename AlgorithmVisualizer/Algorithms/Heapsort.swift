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
            self.steps.append([true, end, 0])
            self.steps.append([false, end])
            end = end - 1
            self.siftDown(&arr, 0, end)
        }
        
        self.steps.append([false, -1])
        self.parent.stopSort()
        self.animate(0)
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
            self.steps.append([false, child])
            if child + 1 <= end && arr[child] < arr[child + 1] {
                child += 1
            }
            
            if arr[root] < arr[child] {
                self.swap(index1: root, index2: child, arr: &arr)
                self.steps.append([true, root, child])
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








//func startSort(on arr: inout [CGFloat]) {
//    let n = arr.count
//
//    self.heapify(&arr, n)
//    
//    var end = n - 1
//    while end > 0 {
//        self.swap(index1: end, index2: 0, arr: &arr)
//        end = end - 1
//        self.siftDown(&arr, 0, end)
//    }
//}
//
//func heapify(_ arr: inout [CGFloat], _ count: Int) {
//    var start: Int = (count - 2) / 2
//    
//    while start >= 0 {
//        self.siftDown(&arr, start, count - 1)
//        start -= 1
//    }
//}
//
//func siftDown(_ arr: inout [CGFloat], _ start: Int, _ end: Int) {
//    var root = start
//    
//    while root * 2 + 1 <= end {
//        var child = root * 2 + 1
//        if child + 1 <= end && arr[child] < arr[child + 1] {
//            child += 1
//        }
//        if arr[root] < arr[child] {
//            self.swap(index1: root, index2: child, arr: &arr)
//            root = child
//        } else {
//            return
//        }
//    }
//}
//
//func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//    let temp = arr[index1]
//    arr[index1] = arr[index2]
//    arr[index2] = temp
//}


