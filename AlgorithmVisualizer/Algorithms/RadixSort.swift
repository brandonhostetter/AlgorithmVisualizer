//
//  RadixSort.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import Foundation
import UIKit

class RadixSort: AlgorithmProtocol {
    var parent: VisualizerView!
    var steps: [[Any]] = []
    var originalArr: [CGFloat] = []
    
    func startSort(on arr: inout [CGFloat], parent: VisualizerView) {
        var sorted = false
        var i = 0
        var digit = 1
        self.parent = parent
        self.originalArr = arr
        
        while !sorted {
            var buckets: [[CGFloat]] = []
            sorted = true
            
            for _ in 0..<10 {
                buckets.append([])
            }
            
            for m in 0..<arr.count {
                i = Int(arr[m]) / digit
                buckets[i % 10].append(arr[m])
                self.steps.append([false, m])
                
                if sorted && i > 0 {
                    sorted = false
                }
            }
            
            if sorted {
                break
            }
            
            var k = 0
            for j in 0..<10 {
                let bucket = buckets[j]
                for x in bucket {
                    self.steps.append([true, k, x])
                    arr[k] = x
                    k += 1
                }
            }
            
            digit *= 10
        }
        
        self.steps.append([false, -1])
        self.parent.stopSort()
        self.animate(0)
    }
    
    func animate(_ index: Int) {
        if index < self.steps.count {
            if self.steps[index][0] as! Bool == true {
                self.parent.update(numbers: self.originalArr, (self.steps[index][1] as! Int))
                self.originalArr[self.steps[index][1] as! Int] = self.steps[index][2] as! CGFloat
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.animate(index + 1)
                })
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
//    var sorted = false
//    var i = 0
//    var digit = 1
//
//    while !sorted {
//        var buckets: [[CGFloat]] = []
//        sorted = true
//        
//        for _ in 0..<10 {
//            buckets.append([])
//        }
//        
//        for x in arr {
//            i = Int(x) / digit
//            buckets[i % 10].append(x)
//            
//            if sorted && i > 0 {
//                sorted = false
//            }
//        }
//        
//        var k = 0
//        for j in 0..<10 {
//            let bucket = buckets[j]
//            for x in bucket {
//                arr[k] = x
//                k += 1
//            }
//        }
//        
//        digit *= 10
//    }
//}



