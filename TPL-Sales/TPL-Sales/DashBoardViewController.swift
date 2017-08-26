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

class DashBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var calendar: UIView!
    @IBOutlet weak var calendarHeader: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var shortName: UILabel!
    @IBOutlet weak var shortAddress: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var allTimeSales: UILabel!
    @IBOutlet weak var salesYTD: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var aboutMe: UITextView!
    @IBOutlet weak var apoointments: UITableView!
    
    var isViewAppointments: Bool = false
    
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
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    // MARK: Table delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableViewHeader") as! AppointmentsHeaderTableViewCell
        cell.add.addTarget(self, action: #selector(self.redirectToPersistView), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableView") as! AppointmentsTableViewCell
        if indexPath.row != 0 {
            cell.topView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isViewAppointments = true
        redirectToPersistView()
        isViewAppointments = false
    }
    
    // MARK: Internal  functions
    
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
    
    func redirectToPersistView()  {
        
        self.performSegue(withIdentifier: "viewAppointment", sender: self)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewAppointment" {
            if let destNC = segue.destination as? UINavigationController {
                if let destVC = destNC.topViewController as? PersistAppointmentsViewController {
                    destVC.isViewAppointments = isViewAppointments
                }
            }
        }
    }
    
}
