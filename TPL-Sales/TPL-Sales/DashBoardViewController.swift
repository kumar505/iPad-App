//
//  DashBoardViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 24/08/17.
//
//

import UIKit
import Charts

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var appointmentsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 12.0, 2.0, 5.0, 14.0, 2.8, 4.2]
        
        let pieLabels = ["Jan", "Feb", "Mar", "Apr"]
        let pieData = [20.0, 4.0, 6.0, 3.0]
        
        pieChartView.centerText = "Sales"
        pieChartView.chartDescription?.position = CGPoint(x: pieChartView.frame.size.width/2, y: 5)
        pieChartView.chartDescription?.textAlign = .justified
        pieChartView.drawEntryLabelsEnabled = false
        
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelCount = months.count
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.granularity = 1.0
        lineChartView.chartDescription?.position = CGPoint(x: lineChartView.frame.size.width/2, y: 5)
        lineChartView.chartDescription?.textAlign = .center
        
        setPieChart(dataPoints: pieLabels, values: pieData)
        setLineChart(dataPoints: months, values: unitsSold)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    func setLineChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        lineChartView.chartDescription?.text = "Line Chart Demo"
        lineChartView.gridBackgroundColor = .clear
    }
    
    func setPieChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        
        let pieChartData = PieChartData()
        pieChartData.addDataSet(pieChartDataSet)
        
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataSet.colors = colors
        
        pieChartView.chartDescription?.text = "Pie Chart Demo"
    }
    
}
