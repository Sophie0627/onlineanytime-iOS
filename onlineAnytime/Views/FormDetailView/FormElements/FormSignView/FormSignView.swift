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
    
    var signTitle: String = ""
    var id: Int = -1
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.signTitle).fixedSize(horizontal: false, vertical: true)
//            DrawingPad(currentDrawing: $currentDrawing,
//                       drawings: $drawings,
//                       color: $color,
//                       lineWidth: $lineWidth)
//                .frame(height: 150)
//            DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth)
            SignatureUI(id: self.id)
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct FormSignView_Previews: PreviewProvider {
    static var previews: some View {
        FormSignView()
    }
}

struct SignatureUI: View {
    var id: Int = -1
    let canvasView = PencilKitRepresentable()
    let imgRect = CGRect(x: 0, y: 0, width: 400.0, height: 100.0)
    
    @EnvironmentObject var screenInfo: ScreenInfo

    var body: some View {
          VStack {
              canvasView.frame(height: 100.0)
                  .border(Color.gray, width: 2)
              Button(action: {
                  self.saveSignature()
              }) {
                  Text("Save Signature")
              }
          }
      }

    func saveSignature() {
        print("---------signature--------")
        let image = canvasView.canvas.drawing.image(from: imgRect, scale: 1.0)
        let imageData = image.pngData()
        let imageBase64String = imageData?.base64EncodedString() ?? "iVBORw0KGgoAAAANSUhEUgAAARgAAAB3CAYAAADYW1+3AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAF9SURBVHhe7dQxAQAADMOg+TfdqcgHIrgBRAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDZAQDRLYHzvK1u9dJ9gQAAAAASUVORK5CYII="
//        print("--------------------\(imageBase64String)")
        self.screenInfo.setValues(elementId: "element_\(self.id)", value: "\(imageBase64String.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.replacingOccurrences(of: "+", with: "%2B"))")
    }
}

struct PencilKitRepresentable : UIViewRepresentable {
    let canvas = PKCanvasView(frame: .init(x: 0, y: 0, width: 400, height: 80))
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) { }
}
