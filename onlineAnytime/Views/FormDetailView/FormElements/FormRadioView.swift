//
//  FormRadioView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI
import RadioGroup

struct FormRadioView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    @State var selection: Int = 0
    
    var radioTitle: String
    var radioId: Int
    
    var body: some View {
        let formOptionDB: FormOptionDBHelper = FormOptionDBHelper()
        
        VStack(alignment: .leading) {
            Text(self.radioTitle).fixedSize(horizontal: false, vertical: true)
            HStack {
                RadioGroupPicker(selectedIndex: $selection, titles: formOptionDB.getOptions(formId: self.screenInfo.formId, elementId: self.radioId))
                    .fixedSize()
                    .onTapGesture(perform: {
                        let length: Int = formOptionDB.getOptions(formId: self.screenInfo.formId, elementId: self.radioId).count
                        var radioParam: Int
                        if self.selection == length - 1 {
                            radioParam = 1
                        } else {
                            radioParam = self.selection + 2
                        }
                        print("------------------selectedIndex \(selection) | radioParam \(radioParam)")
                        screenInfo.setValues(elementId: "element_\(self.radioId)", value: String(radioParam))
                    })
                    .onAppear(perform: {
                        screenInfo.setValues(elementId: "element_\(self.radioId)", value: String(self.selection + 1))
                    })
                Spacer()
            }
        }
    }
}

struct FormRadioView_Previews: PreviewProvider {
    static var previews: some View {
        FormRadioView(radioTitle: "", radioId: -1)
    }
}
