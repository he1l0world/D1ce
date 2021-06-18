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
    @State var showContributor = false
    
    var body: some View {
            GeometryReader{geometry in
             VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        showContributor = true
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .shadow(radius: 3)
                            
                    })
                }
                //.frame(height: geometry.size.height*0.1)
                .padding()
                .padding(.top, geometry.safeAreaInsets.top+geometry.size.height*0.05)
      
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
                 }
                 .padding(.bottom, geometry.safeAreaInsets.bottom + geometry.size
                            .height*HEIGHT)
                 .frame(width: geometry.size
                     .width, height: geometry.size
                        .height*(1-HEIGHT-0.1))
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
            .sheet(isPresented: $showContributor, content: {
                ContributorView()
            })
            .contentShape(Rectangle())
            .onTapGesture{controller.reset()}
            .onLongPressGesture(minimumDuration: 1.5) {controller.changeMode()}
            .background(Image( "background")
                         .resizable()
                         .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                         .ignoresSafeArea(.all)
                         .scaledToFit()
                            )
            .ignoresSafeArea()
            .onShake {
                 controller.reset()
            }
        //.statusBar(hidden: false)
    }
    
    
    
    //Mark: drawing constant
    let HEIGHT:CGFloat = 1/6
    let WIDTH:CGFloat = 1/6
}


// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
