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
    @IBOutlet weak var apointments: UITableView!
    
    var isViewAppointments: Bool = false
    var appointment = AppointmentDataModel()
    var borderWidth: CGFloat = 1.5
    var borderCornerRadius: CGFloat = 1.0
    
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
        calendarView.appearance.headerDateFormat = "MMM yyyy"
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        self.navigationController?.navigationBar.formatUI()
        
        profileView.layer.borderWidth = borderWidth
        profileView.layer.borderColor = ColorConstants.borderLightGrayColor.cgColor
        calendar.layer.borderWidth = borderWidth
        calendar.layer.borderColor = ColorConstants.borderLightGrayColor.cgColor
        pieChartView.layer.borderWidth = borderWidth
        pieChartView.layer.borderColor = ColorConstants.borderLightGrayColor.cgColor
        lineChartView.layer.borderWidth = borderWidth
        lineChartView.layer.borderColor = ColorConstants.borderLightGrayColor.cgColor
        apointments.layer.borderWidth = borderWidth
        apointments.layer.borderColor = ColorConstants.borderLightGrayColor.cgColor
        
        appointment.addAppointment(leadName: "Karthik", phone: 1234567890, address: "ECIL, Hyderabad", appointmentType: "Christmas", start: formatDate(currentDate: Date.init()), end: formatDate(currentDate: Date.init().addingTimeInterval(3600.0)), confirm: false, workEstimate: "WE")
        
        appointment.addAppointment(leadName: "Dilip", phone: 1234567890, address: "ECIL, Hyderabad", appointmentType: "Christmas", start: formatDate(currentDate: Date.init()), end: formatDate(currentDate: Date.init().addingTimeInterval(3600.0)), confirm: true, workEstimate: "WE")
        
        self.apointments.reloadData()
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
        return appointments.count
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
        
        let appointment = appointments[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableView") as! AppointmentsTableViewCell
        if indexPath.row != 0 {
            cell.topView.backgroundColor = ColorConstants.borderLightGrayColor
            cell.topView.isHidden = true
        }
        
        cell.bottomView.isHidden = true
        cell.leftView.isHidden = true
        cell.rightView.isHidden = true
        
        cell.leadCustName.setTitle(appointment.leadName, for: .normal)
        cell.phone.setTitle(appointment.phone?.stringValue, for: .normal)
        cell.address.setTitle(appointment.address, for: .normal)
        cell.appointmentType.text = appointment.appointmentType
        cell.startEndTime.text = "\(String(describing: appointment.startTime!)) / \(String(describing: (appointment.endTime!)))"
        if appointment.confirm! {
            cell.confirm.setTitle("©", for: .normal)
        } else {
            cell.confirm.setTitle("Confirm", for: .normal)
        }
        cell.we.setTitle("WE", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isViewAppointments = true
        redirectToPersistView()
        isViewAppointments = false
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
    
    // MARK: Internal  functions
    
    func setLineChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        lineChartDataSet.circleRadius = 3
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.circleColors = [UIColor.blue]
        lineChartDataSet.colors = [UIColor.blue]
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
    
    func formatDate(currentDate: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: currentDate)
    }
}
