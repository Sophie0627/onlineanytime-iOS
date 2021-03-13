//
//  FormSelectView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormSelectView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    @EnvironmentObject var formElementOptions: FormElementOptionViewModel
    
    var selectTitle: String
    var selectId: Int
    
    
    @State private var selectedFrameworkIndex = 0
    
    var body: some View {
        let options = self.formElementOptions.getOptions(formId: self.screenInfo.formId, elementId: self.selectId)
        VStack(spacing: 0.0) {
            Text(self.selectTitle + ": \(options[selectedFrameworkIndex])").fixedSize(horizontal: false, vertical: true)
            Picker(selection: $selectedFrameworkIndex, label: Text("")) {
                ForEach(0 ..< options.count) {
                    Text(options[$0])
                }
            }.fixedSize()
        }.padding()
    }
}

struct FormSelectView_Previews: PreviewProvider {
    static var previews: some View {
        FormSelectView(selectTitle: "", selectId: -1)
    }
}
