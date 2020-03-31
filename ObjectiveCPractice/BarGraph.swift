//
//  BarGraph.swift
//  GraphLib
//
//  Created by parker amundsen on 1/1/20.
//  Copyright © 2020 Parker Buhler Amundsen. All rights reserved.
//

import Foundation
import UIKit

class BarGraph <T: Comparable & BinaryInteger> : UIView {
    
    
    //MARK: Private instance vars
    private var barGraphData: Array<(T,String)> = []
    private var bars: Array<UIView> = []
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    //MARK: Public instance vars
    public var barColor : UIColor = UIColor.white
    public var barCornerRadius : CGFloat = 0
    public var spaceBetweenBars : CGFloat = 0 {
        willSet(newValue) {
            if newValue >= 0 {
                self.spaceBetweenBars = newValue
            }
        }
    }
    public var includeValueLabels : Bool = true {
        willSet {
            self.includeValueLabels = !self.includeValueLabels
        }
    }
    
   
    //MARK: Initializers
    public init(frame: CGRect, data: [T], labels: [String], title: String = "") {
        super.init(frame: frame)
        loadData(data: data, labels: labels)
        titleLabel.text = title
    }
    
    public init(data: [T], labels: [String], title: String = "") {
        super.init(frame: CGRect())
        loadData(data: data, labels: labels)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public functions
    public func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    public func displayData() {
        // Determine the scale
        let max = determineMaxScale()
        // Determine the height
        addBarsToGraph(max: max)
        // Determine the width of each bar
        setLabels()
        
        if (includeValueLabels) {
            setValueLabels()
        }
        addTitleLabelConstraints()
    }
    
    // Used to populate the bar graph with data, must include labels
    public func loadData(data: [T], labels: [String]) {
        barGraphData = []
        let minIndex = (data.count < labels.count) ? data.count:labels.count
        for index in 0..<minIndex {
            barGraphData[index].0 = data[index]
            barGraphData[index].1 = labels[index]
        }
    }
    
    //MARK: Private functions
    private func addTitleLabelConstraints() {
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    private func setLabels() {
        for index in 0..<barGraphData.count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.text = barGraphData[index].1
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 1
            self.addSubview(label)
            label.centerXAnchor.constraint(equalTo: bars[index].centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: bars[index].bottomAnchor).isActive = true
            label.widthAnchor.constraint(equalTo: bars[index].widthAnchor, constant: spaceBetweenBars).isActive = true
        }
    }
    
    private func setValueLabels() {
        for index in 0..<barGraphData.count {
            let valueLabel = UILabel()
            valueLabel.textAlignment = .center
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.text = String(barGraphData[index].0)
            valueLabel.numberOfLines = 1
            self.addSubview(valueLabel)
            valueLabel.centerXAnchor.constraint(equalTo: bars[index].centerXAnchor).isActive = true
            valueLabel.bottomAnchor.constraint(equalTo: bars[index].topAnchor, constant: -5).isActive = true
        }
    }
    
    private func addBarsToGraph(max: T) {
        // array used for determining the height of each bar on the bar graph
        var heightRatio : [Float] = []
        for value in barGraphData {
            let maxRatio : Float = 0.8
            let ratioRelativeToMax = (Float(value.0)/Float(max))*maxRatio
            heightRatio.append(ratioRelativeToMax)
        }
        
        // Used to determine the width of each bar on the bar graph
        let multiplier = 1/CGFloat(barGraphData.count)
        
        //add first bar
        let bar = UIView()
        bar.backgroundColor = barColor
        self.addSubview(bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        bar.widthAnchor.constraint(equalTo:self.widthAnchor, multiplier: multiplier, constant: -spaceBetweenBars).isActive = true
        bar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spaceBetweenBars/2).isActive = true
        bar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(heightRatio[0])).isActive = true
        bar.layer.cornerRadius = barCornerRadius
        bars.append(bar)
        
        //add remaining bars
        for index in 1..<barGraphData.count {
            let bar = UIView()
            bar.backgroundColor = barColor
            self.addSubview(bar)
            bar.translatesAutoresizingMaskIntoConstraints = false
            bar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
            bar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(heightRatio[index])).isActive = true
            bar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier, constant: -spaceBetweenBars).isActive = true
            bar.leadingAnchor.constraint(equalTo: bars.last!.trailingAnchor, constant: spaceBetweenBars).isActive = true
            bar.layer.cornerRadius = barCornerRadius
            bars.append(bar)
        }
        
    }
    
    private func determineMaxScale() -> T {
        return barGraphData.max(by: { (a, b) in a.0 < b.0 })?.0 ?? 0
    }
}
