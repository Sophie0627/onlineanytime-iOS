//
//  FormCheckBoxView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormCheckBoxView: View {
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var checkboxTitle: String
    var checkboxtId: Int
    
    
    @State private var selectedFrameworkIndex = 0
    
    var body: some View {
        let formOptionDB: FormOptionDBHelper = FormOptionDBHelper()
        let options = formOptionDB.getOptions(formId: self.screenInfo.formId, elementId: self.checkboxtId)
        VStack(alignment: .leading) {
            Text(self.checkboxTitle).fixedSize(horizontal: false, vertical: true)
            ForEach(0 ..< options.count) {
                CheckboxFieldView(text: options[$0], tag: $0, id: self.checkboxtId)
            }
        }
    }
}

struct FormCheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        FormCheckBoxView(checkboxTitle: "", checkboxtId: -1)
    }
}

struct CheckboxFieldView : View {

    @EnvironmentObject var screenInfo: ScreenInfo
    @State var checkState:Bool = false
    var text: String
    var tag: Int
    var id: Int

    var body: some View {

         Button(action:
            {
                //1. Save state
                self.checkState = !self.checkState
                print("State : \(self.checkState)")
                if checkState {
                    screenInfo.setValues(elementId: "element_\(self.id)_\(self.tag + 1)", value: "1")
                } else {
                    screenInfo.setValues(elementId: "element_\(self.id)_\(self.tag + 1)", value: "0")
                }

        }) {
            HStack(alignment: .top, spacing: 10) {

                //2. Will update according to state
               Rectangle()
                        .fill(self.checkState ? Color.green : Color.red)
                        .frame(width:20, height:20, alignment: .center)
                        .cornerRadius(5)

                Text(self.text).foregroundColor(.black)
                Spacer()
            }
        }
        .foregroundColor(Color.white)

    }

}
