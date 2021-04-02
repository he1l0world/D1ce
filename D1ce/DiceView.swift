//
//  DiceView.swift
//  D1ce
//
//  Created by Dawson Chen on 3/30/21.
//

import SwiftUI

struct DiceView: View {
    var dice: Dice

    @State var location: CGPoint
    
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 5.0).fill(dice.color)
                Image("dice_"+"\(dice.value)")
                    .resizable()
                    .aspectRatio( 0.9, contentMode: .fit)
                    //.background(RoundedRectangle(cornerRadius: 10.0).fill(dice.color))
                    .scaledToFit()
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 1).speed(2)) {location = dice.location}
            }
            .position(location)
            .gesture(simpleDrag.simultaneously(with: fingerDrag))
        }
        
    }
    
    
    
    //Mark: drawing constant
    let HEIGHT:CGFloat = 1/6
    let WIDTHWIDTHWIDTHWIDTH:CGFloat = 1/6
 

}





struct DiceView_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometryReader{geometry in
            DiceView(dice: Dice(value: Int.random(in: 1..<7), color: .white, location: CGPoint(x: UIScreen.main.bounds.width*CGFloat.random(in: -1/3..<1/3), y: UIScreen.main.bounds.height*CGFloat.random(in: -1/3..<1/3))), location: DiceController.start)

                .frame(width: geometry.size
                    .width*(1/6), height: geometry.size
                        .width*(1/6))
         }
        .background(Image( "background")
                     .resizable()
                     .frame(width: UIScreen.main.bounds
                         .width, height: UIScreen.main.bounds
                             .height)
                     .ignoresSafeArea(.all)
                     .scaledToFit()
                        )
         .ignoresSafeArea()
    }
    
}
