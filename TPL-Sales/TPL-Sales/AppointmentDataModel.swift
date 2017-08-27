//
//  AppointmentDataModel.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 27/08/17.
//
//

import Foundation

class AppointmentDataModel {
    
    var leadName: String?
    var phone: NSNumber?
    var address: String?
    var appointmentType: String?
    var startTime: String?
    var endTime: String?
    var confirm: Bool?
    var workEstimate: String?
    
    func addAppointment(leadName: String, phone: NSNumber, address: String, appointmentType: String, start: String, end: String, confirm: Bool, workEstimate: String) {
        
        let appointment = AppointmentDataModel()
        
        appointment.leadName = leadName
        appointment.phone = phone
        appointment.address = address
        appointment.appointmentType = appointmentType
        appointment.startTime = start
        appointment.endTime = end
        appointment.confirm = confirm
        appointment.workEstimate = workEstimate
        
        appointments.append(appointment)
    }
    
}
