//
//  ContributorView.swift
//  D1ce
//
//  Created by Dawson Chen on 5/19/21.
//

import SwiftUI


struct ContributorView: View {
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                Text("Contributor List")
                    .CustomFont()
                    .frame(width: proxy.size.width, height: proxy.size.height/5)
                
                ForEach(Array(content), id: \.0){ item in
                    HStack{
                        Text(item.0)
                            .CustomFont()
                        Text(item.1)
                            .CustomFont()
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height/4)
                }
                
            }
        }
        //.navigationBarHidden(true)
        .background(Image( "background")
                     .resizable()
                     .frame(width: UIScreen.main.bounds
                         .width, height: UIScreen.main.bounds
                             .height)
                     .ignoresSafeArea(.all)
                     .scaledToFit()
                        )
    }
    
    //MARK: Drawing component
    private let content = ["Graphics": "Viki", "Icon": "Eric",  "Logic": "Dawson"]

}


struct ContributorView_Previews: PreviewProvider {
    static var previews: some View {
        ContributorView()
    }
}
