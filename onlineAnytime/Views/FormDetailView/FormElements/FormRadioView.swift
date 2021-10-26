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
                    .onChange(of: selection, perform: { selection in
                                               
                        print("------------------ radio selectedIndex \(selection)")
                        screenInfo.setValues(elementId: "element_\(self.radioId)", value: String(selection + 1))
                    })
                    .onAppear(perform: {
                        let str: String = screenInfo.getValue(elementId: "element_\(self.radioId)")
                        if str != "###"
                        {
                            
                            self.selection = Int(str)! - 1
                            
                            print("radio \(str) selection \(selection)")
                        } else {
                            screenInfo.setValues(elementId: "element_\(self.radioId)", value: String(self.selection + 1))
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




