//
//  FormSignView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import SwiftUI
import PencilKit

struct FormSignView: View {
    @State private var currentDrawing: Drawing = Drawing()
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    @State private var rect: CGRect = .zero
    
    var signTitle: String = ""
    var id: Int = -1
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.signTitle).fixedSize(horizontal: false, vertical: true)
            DrawingPad(currentDrawing: $currentDrawing,
                       drawings: $drawings,
                       color: $color,
                       lineWidth: $lineWidth)
                .frame(height: 150)
                .background(RectGetter(rect: $rect))
            DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth, rect: self.rect, id: self.id)
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct FormSignView_Previews: PreviewProvider {
    static var previews: some View {
        FormSignView()
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

struct RectGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}
