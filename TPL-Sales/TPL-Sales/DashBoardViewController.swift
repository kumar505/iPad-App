//
//  DashBoardViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 24/08/17.
//
//

import UIKit
import Charts
import FSCalendar

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var calendar: UIView!
    @IBOutlet weak var appointmentsView: UIView!
    @IBOutlet weak var calendarHeader: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 12.0, 2.0, 5.0, 14.0, 2.8, 4.2]
        
        let pieLabels = ["Christmas", "Event", "Landscape"]
        let pieData = [20.0, 4.0, 6.0, 3.0]
        
        pieChartView.centerText = "30.0"
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
        
        calendarView.clipsToBounds = true
        calendarView.layer.borderWidth = 0.5
        calendarView.layer.borderColor = UIColor.darkGray.cgColor
        calendarView.appearance.headerDateFormat = "MMM yyyy"
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
        lineChartDataSet.circleRadius = 2
        lineChartDataSet.drawValuesEnabled = false
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        lineChartView.chartDescription?.text = "12 Month Rolling Sales"
        lineChartView.gridBackgroundColor = .clear
    }
    
    func setPieChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        let colors: [UIColor] = [UIColor.green, UIColor.orange, UIColor.blue]
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        pieChartDataSet.colors = colors
        
        let pieChartData = PieChartData()
        pieChartData.addDataSet(pieChartDataSet)
        
        pieChartView.data = pieChartData
        pieChartView.chartDescription?.text = "Sales (YTD)"
    }
    
}
