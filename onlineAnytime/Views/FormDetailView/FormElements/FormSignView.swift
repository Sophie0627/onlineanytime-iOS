//
//  FormSignView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import SwiftUI

struct FormSignView: View {
    @State private var currentDrawing: Drawing = Drawing()
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    
    var signTitle: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.signTitle)
            DrawingPad(currentDrawing: $currentDrawing,
                       drawings: $drawings,
                       color: $color,
                       lineWidth: $lineWidth)
                .frame(height: 150)
            DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth)
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct FormSignView_Previews: PreviewProvider {
    static var previews: some View {
        FormSignView()
    }
}
