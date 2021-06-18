//
//  Extentions.swift
//  D1ce
//
//  Created by Dawson Chen on 6/17/21.
//

import Foundation
import SwiftUI
extension Text{
    func CustomFont() -> some View{
        // the foreground color can be found in DrawingConstants.swift file class MeasureViewDrawingConstants
        self.bold()
            .underline()
            .foregroundColor(.white)
            .font(.largeTitle)
//            .font(.custom("ANDTIOHOneRegular", size: 20, relativeTo: .caption))
//            .font(.custom("BulgattiRegular", size: 30, relativeTo: .caption))
    }
}

