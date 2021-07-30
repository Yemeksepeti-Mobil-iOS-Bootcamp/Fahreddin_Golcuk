//
//  Ticket.swift
//  busAutomation
//
//  Created by Fahreddin Gölcük on 13.07.2021.
//
import Foundation

class Ticket {
    var seats: [Seat] = []
    var passenger: Passenger = Passenger()
    var date: Date = Date()
    var seatCount: Int = 0

    func isSeatValidated(seat: Seat) -> Bool {
        if(seat.type == .empty) {
            return true
        } else {
            return false
        }
    }
    
    func printTicket() {
        var seatLbl: String = ""
        for seat in self.seats {
            seatLbl += "\(seat.seatNumber)-\(seat.type == .man ? "Erkek" : "Kadın") |"
        }
        print("------------------------------------------------------")
        print("-- SEAT COUNT : \(self.seatCount)")
        print("-- PASSENGER FULL NAME : \(self.passenger.fullName)")
        print("-- DATE : \(self.date)")
        print("-- SEATS : \(seatLbl)")
        print("------------------------------------------------------")
    }
    
}
