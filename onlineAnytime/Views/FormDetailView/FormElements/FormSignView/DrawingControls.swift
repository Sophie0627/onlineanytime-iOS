//
//  DrawingControls.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//


import SwiftUI

struct DrawingControls: View {
    @Binding var color: Color
    @Binding var drawings: [Drawing]
    @Binding var lineWidth: CGFloat
    
    @State private var colorPickerShown = false

    private let spacing: CGFloat = 40
    
    var body: some View {
        VStack {
            HStack(spacing: spacing) {
                Button("Save") {
//                        self.colorPickerShown = true
                }
                Button("Undo") {
                    if self.drawings.count > 0 {
                        self.drawings.removeLast()
                    }
                }
                Button("Clear") {
                    self.drawings = [Drawing]()
                }
            }
        }
//        .frame(height: 100)
    }
}
