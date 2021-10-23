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
    @State private var uiimage: UIImage? = nil
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var rect: CGRect = .zero
    var id: Int = -1

    private let spacing: CGFloat = 40
    
    var body: some View {
        VStack {
            HStack(spacing: spacing) {
                Button("Save") {
//                        self.colorPickerShown = true
                    self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: self.rect)
                    let imageData = self.uiimage!.pngData()
                    let imageBase64String: String = imageData?.base64EncodedString() ?? ""
                    self.screenInfo.setValues(elementId: "element_\(self.id)", value: "data:image/png;base64,\(imageBase64String.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.replacingOccurrences(of: "+", with: "%2B"))")
                    self.screenInfo.setValues(elementId: "tmp_element_\(self.id)", value: "data:image/png;base64,\(imageBase64String.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.replacingOccurrences(of: "+", with: "%2B"))")
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
