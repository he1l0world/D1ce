//
//  HomeView.swift
//  D1ce
//
//  Created by Dawson Chen on 3/30/21.
//

import SwiftUI


struct HomeView: View {

    @State var number: Int = 5
    @ObservedObject var controller: DiceController = DiceController(Number: 5)
    @State var refresh: Bool = false
    
    var body: some View {
       GeometryReader{geometry in
        VStack{
            ZStack{
                ForEach(controller.DiceList){d in
                    return DiceView(dice: d, location: DiceController.start)
                        .frame(width: geometry.size
                            .width*WIDTH, height: geometry.size
                                .width*HEIGHT)
                        .onTapGesture(count: 2){
                            if let index = controller.DiceList.firstIndex(of: d){
                                controller.DiceList[index].changeValue(1)
                            }

                        }
                        
                }
//                Text("\(controller.DiceList[controller.DiceList.count-1].value)")
//                    .foregroundColor(.white)
            }
            .frame(width: geometry.size
                .width, height: geometry.size
                    .height*(1-HEIGHT))
            HStack(spacing: 30){
                Button(action: {
                    number -= 1
                    if number < 1{
                        number = 1
                    }
                    controller.changeNumber(number)
                }, label: {
                    Image(systemName: "minus")
                        .foregroundColor(.orange)
                        .font(.largeTitle)
                })
                
                Text("\(number)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Button(action: {
                    number += 1
                    controller.changeNumber(number)
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                        .font(.largeTitle)
                })
            }
            .frame(width: geometry.size
                .width, height: geometry.size
                    .height*HEIGHT)
            
        }
        .frame(width: geometry.size
            .width, height: geometry.size
                .height)
       }
       .contentShape(Rectangle())
       .onTapGesture{controller.reset()}
       .onLongPressGesture(minimumDuration: 1.5) {controller.changeMode()}
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
    
    
    
    //Mark: drawing constant
    let HEIGHT:CGFloat = 1/6
    let WIDTH:CGFloat = 1/6
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
