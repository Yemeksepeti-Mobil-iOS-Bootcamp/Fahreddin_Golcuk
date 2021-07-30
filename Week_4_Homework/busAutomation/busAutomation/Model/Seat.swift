//
//  Seat.swift
//  busAutomation
//
//  Created by Fahreddin Gölcük on 13.07.2021.
//

class Seat {
    let type: SeatType
    let seatNumber: Int
    
    init(type: SeatType, seatNumber: Int) {
        self.type = type
        self.seatNumber = seatNumber
    }
}
