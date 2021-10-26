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
        let optionIdArray: [String] = formOptionDB.getOptionIds(formId: self.screenInfo.formId, elementId: self.radioId)
        
        VStack(alignment: .leading) {
            Text(self.radioTitle).fixedSize(horizontal: false, vertical: true)
            HStack {
                RadioGroupPicker(selectedIndex: $selection, titles: formOptionDB.getOptions(formId: self.screenInfo.formId, elementId: self.radioId))
                    .fixedSize()
                    .onChange(of: selection, perform: { selection in
                                               
                        print("------------------ radio selectedIndex \(selection)")
                        screenInfo.setValues(elementId: "element_\(self.radioId)", value: String(Int(optionIdArray[selection])!))
                        screenInfo.setValues(elementId: "tmp_element_\(self.radioId)", value: String(selection + 1))
                    })
                    .onAppear(perform: {
                        print("optionIdArray \(optionIdArray)")
                        var str: String = screenInfo.getValue(elementId: "element_\(self.radioId)")
                        if str != "###"
                        {
                            str = screenInfo.getValue(elementId: "tmp_element_\(self.radioId)")
                            self.selection = Int(str)! - 1
                            
                            print("radio \(str) selection \(selection)")
                        } else {
                            screenInfo.setValues(elementId: "element_\(self.radioId)", value: String(Int(optionIdArray[selection])!))
                            screenInfo.setValues(elementId: "tmp_element_\(self.radioId)", value: String(selection + 1))
                        }
                        
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




