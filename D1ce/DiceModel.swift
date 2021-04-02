//
//  DiceModel.swift
//  D1ce
//
//  Created by Dawson Chen on 3/30/21.
//

import Foundation
import SwiftUI

struct Dice: Identifiable, Equatable{
    var id = UUID()
    var value: Int
    var color: Color
    var location: CGPoint = CGPoint(x: UIScreen.main.bounds.width*(2/3), y: 0)
    
    public mutating func changeValue(_ value: Int){
        self.value = value
    }
    
    public mutating func changeLocation(_ location: CGPoint){
        self.location = location
    }
    
    static func ==(lhs: Dice, rhs: Dice) -> Bool {
        return lhs.id == rhs.id
    }
}
