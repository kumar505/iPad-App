//
//  ViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 18/08/17.
//
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var shortName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var allTimeSales: UILabel!
    @IBOutlet weak var salesYTD: UILabel!
    @IBOutlet weak var aboutMe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 12.0, 2.0, 5.0, 14.0, 2.8, 4.2]
        
        pieChart.centerText = "Sales"
        pieChart.chartDescription?.position = CGPoint(x: pieChart.frame.size.width/2, y: 5)
        pieChart.chartDescription?.textAlign = .justified
        pieChart.drawEntryLabelsEnabled = false
        
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelCount = months.count
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChart.xAxis.granularity = 1.0
        lineChart.chartDescription?.position = CGPoint(x: lineChart.frame.size.width/2, y: 5)
        lineChart.chartDescription?.textAlign = .center
        
        setPieChart(dataPoints: months, values: unitsSold)
        setLineChart(dataPoints: months, values: unitsSold)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        pieChart.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        lineChart.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    func setLineChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        
        lineChart.chartDescription?.text = "Line Chart Demo"
        lineChart.gridBackgroundColor = .clear
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
        
        pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataSet.colors = colors
        
        pieChart.chartDescription?.text = "Pie Chart Demo"
    }
    
}
