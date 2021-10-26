//
//  FormMatrixView.swift
//  onlineAnytime
//
//  Created by Kei on 10/25/21.
//

import SwiftUI

struct FormMatrixView: View {
    var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]

    var colors: [Color] = [.yellow, .purple, .green]

    var gridItemLayout = [GridItem(.fixed(100))] + Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)
    
    @EnvironmentObject var screenInfo: ScreenInfo
    @State var selection: Int = 0
    
    var matrixTitle: String
    var matrixId: Int
    var matrixGuideline: String
    var matrixConstraint: String
    
    var body: some View {
        let formOptionDB: FormOptionDBHelper = FormOptionDBHelper()
        let optionArray: [String] = formOptionDB.getOptions(formId: self.screenInfo.formId, elementId: self.matrixId)
        
        
        VStack {
            if matrixConstraint != "" {
                Text(matrixGuideline)
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    Text("")
                    ForEach(optionArray, id: \.self) { option in
                        Text(option)
                    }
                    
                }
            }
            
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                
                Text(matrixTitle)
                ForEach(0..<optionArray.count) { index in
                    RadioButton(index, callback: self.radioGroupCallback, selectedID: self.selection)
                }
            
        }
        }.onAppear(perform: {
            print("optionArray \(optionArray)")
            let str: String = screenInfo.getValue(elementId: "element_\(self.matrixId)")
            if str != "###"
            {
                
                self.selection = Int(str)!
                
                print("radio \(str) selection \(selection)")
            } else {
                screenInfo.setValues(elementId: "element_\(self.matrixId)", value: String(self.selection + 1))
            }

        })
    }
    
    func radioGroupCallback(id: Int) {
        print("selected \(id)")
        self.selection = id
        screenInfo.setValues(elementId: "element_\(self.matrixId)", value: String(self.selection + 1))
    }
}

//struct FormMatrixView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormMatrixView()
//    }
//}

struct ColorInvert: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        Group {
            if colorScheme == .dark {
                content.colorInvert()
            } else {
                content
            }
        }
    }
}

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let id: Int
    let callback: (Int)->()
    let selectedID : Int
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let text: String

    init(
        _ id: Int,
        callback: @escaping (Int)->(),
        selectedID: Int,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14,
        text: String = ""
        ) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
        self.text = text
    }

    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selectedID == self.id ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .modifier(ColorInvert())
                Text(self.text)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(self.color)
    }
}
