//
//  FormSelectView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormSelectView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var selectTitle: String
    var selectId: Int
    
    
    @State private var selectedFrameworkIndex = 0
    
    var body: some View {
        let formOptionDB: FormOptionDBHelper = FormOptionDBHelper()
        let options = formOptionDB.getOptions(formId: self.screenInfo.formId, elementId: self.selectId)
        
        VStack(spacing: 0.0) {
            Text(self.selectTitle + ": \(options[selectedFrameworkIndex])").fixedSize(horizontal: false, vertical: true)
            Picker(selection: $selectedFrameworkIndex, label: Text("")) {
                ForEach(0 ..< options.count) {
                    Text(options[$0]).tag([$0])
                }
            }.fixedSize()
            .onChange(of: selectedFrameworkIndex, perform: {tag in
                screenInfo.setValues(elementId: "element_\(self.selectId)", value: String(tag + 1))
            })
            .onAppear(perform: {
                screenInfo.setValues(elementId: "element_\(self.selectId)", value: "1")
            })
        }.padding()
    }
}

struct FormSelectView_Previews: PreviewProvider {
    static var previews: some View {
        FormSelectView(selectTitle: "", selectId: -1)
    }
}
