//
//  MergeSort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class MergeSort: AlgorithmProtocol {
    var parent: VisualizerView!
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []
    
    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        let n = arr.count - 1
        self.parent = parent
        self.originalArr = arr
        
        self.mergeSort(&arr, 0, n)
        self.parent.update(numbers: arr)
        
        self.steps.append([false, -1])
        self.parent.stopSort()
        self.animate(0)
    }
    
    func mergeSort(_ arr: inout [CGFloat], _ begin: Int, _ end: Int) {
        if begin - end == 0 {
            
        } else if end - begin == 1 {
            if arr[begin] > arr[end] {
                self.steps.append([false, begin])
                self.steps.append([false, end])
                self.swap(index1: begin, index2: end, arr: &arr)
                self.steps.append([true, begin, end])
            }
        } else {
            let middle: Int = (begin + end) / 2
            
            self.mergeSort(&arr, begin, middle)
            self.mergeSort(&arr, middle + 1, end)
            self.merge(&arr, begin, end, middle)
        }
    }
    
    func merge(_ arr: inout [CGFloat], _ begin: Int, _ end: Int, _ middle: Int) {
        var i = begin
        
        while i <= middle {
            self.steps.append([false, i])
            if arr[i] > arr[middle + 1] {
                self.swap(index1: i, index2: middle + 1, arr: &arr)
                self.steps.append([true, i, middle + 1])
                self.moveLargestToEnd(&arr, middle + 1, end)
            }
            
            i += 1
        }
    }
    
    func moveLargestToEnd(_ arr: inout [CGFloat], _ begin: Int, _ end: Int) {
        for i in begin..<end {
            if arr[i] > arr[i + 1] {
                self.swap(index1: i, index2: i + 1, arr: &arr)
                self.steps.append([false, i])
                self.steps.append([true, i, i + 1])
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                    self.animate(index + 1)
                })
            }
        }
    }
}








// Top down implementation
//func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
//    let n = arr.count
//    var workArr: [CGFloat] = arr
//    self.parent = parent
//    self.originalArr = arr
//    
//    self.topDownSplitMerge(&workArr, 0, n, &arr)
//    self.parent.update(numbers: arr)
//}
//
//func topDownSplitMerge(_ workArr: inout [CGFloat], _ begin: Int, _ end: Int, _ arr: inout [CGFloat]) {
//    if end - begin < 2 {
//        return
//    }
//    
//    let middle = (end + begin) / 2
//    self.topDownSplitMerge(&arr, begin, middle, &workArr)
//    self.topDownSplitMerge(&arr, middle, end, &workArr)
//    self.topDownMerge(&workArr, begin, middle, end, &arr)
//}
//
//func topDownMerge(_ arr: inout [CGFloat], _ begin: Int, _ middle: Int, _ end: Int, _ workArr: inout [CGFloat]) {
//    var i = begin
//    var j = middle
//    
//    for k in begin..<end {
//        if i < middle && (j >= end || arr[i] <= arr[j]) {
//            workArr[k] = arr[i]
//            i += 1
//        } else {
//            workArr[k] = arr[j]
//            j += 1
//        }
//    }
//}









// Sort actually used here - in place merge sort
//func startSort(on arr: inout [CGFloat]) {
//    let n = arr.count - 1
//    
//    self.mergeSort(&arr, 0, n)
//    self.parent.update(numbers: arr)
//}
//
//func mergeSort(_ arr: inout [CGFloat], _ begin: Int, _ end: Int) {
//    if begin - end == 0 {
//        
//    } else if end - begin == 1 {
//        if arr[begin] > arr[end] {
//            self.swap(index1: begin, index2: end, arr: &arr)
//        }
//    } else {
//        let middle: Int = (begin + end) / 2
//        
//        self.mergeSort(&arr, begin, middle)
//        self.mergeSort(&arr, middle + 1, end)
//        self.merge(&arr, begin, end, middle)
//    }
//}
//
//func merge(_ arr: inout [CGFloat], _ begin: Int, _ end: Int, _ middle: Int) {
//    var i = begin
//    
//    while i <= middle {
//        if arr[i] > arr[middle + 1] {
//            self.swap(index1: i, index2: middle + 1, arr: &arr)
//            self.moveLargestToEnd(&arr, middle + 1, end)
//        }
//        
//        i += 1
//    }
//}
//
//func moveLargestToEnd(_ arr: inout [CGFloat], _ begin: Int, _ end: Int) {
//    for i in begin..<end {
//        if arr[i] > arr[i + 1] {
//            self.swap(index1: i, index2: i + 1, arr: &arr)
//        }
//    }
//}
//
//func swap(index1: Int, index2: Int, arr: inout [CGFloat]) {
//    let temp = arr[index1]
//    arr[index1] = arr[index2]
//    arr[index2] = temp
//}



