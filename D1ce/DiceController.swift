//
//  DiceController.swift
//  D1ce
//
//  Created by Dawson Chen on 3/30/21.
//

import SwiftUI
import AVFoundation

class DiceController: ObservableObject{
    static let start: CGPoint = CGPoint(x: UIScreen.main.bounds.width*(2/3), y: UIScreen.main.bounds.height/2)
    var diceSoundEffect: AVAudioPlayer?
    @Published var DiceNumber: Int
    @Published var DiceList: Array<Dice>
    @Published var trickMode: Bool{
        didSet{
            reset()

        }
        //get{return self.trickMode}
    }
    init(Number: Int) {
        
        DiceNumber = Number
        DiceList = Array<Dice> ()
        trickMode = false
        for _ in 0..<DiceNumber{
            DiceList.append(Dice(value: Int.random(in: 1..<7), color: .white, location: CGPoint(x: UIScreen.main.bounds.width*CGFloat.random(in: -1/3..<1/3), y: UIScreen.main.bounds.height*CGFloat.random(in: -1/5..<1/2))))
        }
        
        let path = Bundle.main.path(forResource: "dice_sound.m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            diceSoundEffect = try AVAudioPlayer(contentsOf: url)
            diceSoundEffect?.play()
        } catch {
            // couldn't load file
        }
    }
    
    
    // MARK: - Intent(s)
    
    func changeMode(){
        self.trickMode = !trickMode
        //print("mode changed"+"\(self.trickMode)")
    }
    
    func reset() {
        diceSoundEffect?.play()
        DiceList.removeAll()
        if trickMode == false{
            for _ in 0..<DiceNumber{
                DiceList.append(Dice(value: Int.random(in: 1..<7), color: .white, location: CGPoint(x: UIScreen.main.bounds.width*CGFloat.random(in: -1/3..<1/3), y: UIScreen.main.bounds.height*CGFloat.random(in: -1/5..<1/2))))
            }
        }
        else{
            let value = Int.random(in: 1..<7)
            for _ in 0..<DiceNumber{
                DiceList.append(Dice(value: value, color: .white, location: CGPoint(x: UIScreen.main.bounds.width*CGFloat.random(in: -1/3..<1/3), y: UIScreen.main.bounds.height*CGFloat.random(in: -1/5..<1/2))))
            }
        }
    }
    
    func changeNumber(_ number: Int) {
        
        DiceNumber = number
        reset()
    }

}


