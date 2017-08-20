//
//  VisualizerView.swift
//  AlgorithmVisualizer
//
//  Created by Brandon Hostetter on 8/16/17.
//  Copyright © 2017 Brandon Hostetter. All rights reserved.
//

import UIKit

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

class VisualizerView: UIView {
    let count = 19
    let spacing = 2
    var algorithmType: String?
    var numbers: [CGFloat] = []
    var isSorting = false
    var sorter: AlgorithmProtocol!
    var highlight: Int = -1
    
    func generateRandomNumbers(_ count: Int) -> [CGFloat] {
        var numbers: [CGFloat] = []
        for i in 1...count {
//            numbers.append(CGFloat(arc4random_uniform(UInt32(count))))
            numbers.append(CGFloat(i))
        }
        numbers.shuffle()
        return numbers
    }
    
    func draw() {
        let frame = self.frame
        let width = (frame.width - CGFloat(spacing * count - spacing)) / CGFloat(count)
        let context = UIGraphicsGetCurrentContext()
        
        for i in 0..<numbers.count {
            let height = numbers[i] / CGFloat.init(count) * frame.height
            let rectangle = CGRect(x: CGFloat(i) * width + CGFloat(i * spacing), y: frame.height - height, width: width, height: height)
            
            if i == self.highlight {
                context?.setFillColor(UIColor.green.cgColor)
            } else {
                context?.setFillColor(UIColor.blue.cgColor)
            }
            
            context?.fill(rectangle)
        }
    }
    
    func startSort(_ type: String) {
        self.algorithmType = type
        self.isSorting = true
        
        switch type {
            case Algorithm.BubbleSort["key"]!:
                self.sorter = BubbleSort()
                break
            case Algorithm.Heapsort["key"]!:
                self.sorter = Heapsort()
                break
            case Algorithm.InsertionSort["key"]!:
                self.sorter = InsertionSort()
                break
            case Algorithm.MergeSort["key"]!:
                self.sorter = MergeSort()
                break
            case Algorithm.Quicksort["key"]!:
                self.sorter = QuickSort()
                break
            case Algorithm.RadixSort["key"]!:
                self.sorter = RadixSort()
                break
            case Algorithm.SelectionSort["key"]!:
                self.sorter = SelectionSort()
                break
            default:
                break
        }
        
        self.sorter.startSort(on: &self.numbers, parent: self)
    }
    
    func update(numbers: [CGFloat], _ highlight: Int? = -1) {
        self.numbers = numbers
        self.setNeedsDisplay()
        self.highlight = highlight ?? -1
    }
    
    func stopSort() {
//        self.isSorting = false
//        self.sorter = nil
//        self.numbers = generateRandomNumbers(count)
//        self.highlight = -1
    }
    
    override func draw(_ rect: CGRect) {
        if self.isSorting == false {
            self.numbers = generateRandomNumbers(count)
            self.draw()
        } else {
            self.draw()
        }
    }
}

