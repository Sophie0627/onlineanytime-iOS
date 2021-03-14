//
//  FormCheckBoxView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/12/21.
//

import SwiftUI

struct FormCheckBoxView: View {
    @EnvironmentObject var screenInfo: ScreenInfo
    @EnvironmentObject var formElementOptions: FormElementOptionViewModel
    
    var checkboxTitle: String
    var checkboxtId: Int
    
    
    @State private var selectedFrameworkIndex = 0
    
    var body: some View {
        let options = self.formElementOptions.getOptions(formId: self.screenInfo.formId, elementId: self.checkboxtId)
        VStack(alignment: .leading) {
            Text(self.checkboxTitle).fixedSize(horizontal: false, vertical: true)
            ForEach(0 ..< options.count) {
                CheckboxFieldView(text: options[$0])
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

    @State var checkState:Bool = false
    var text: String

    var body: some View {

         Button(action:
            {
                //1. Save state
                self.checkState = !self.checkState
                print("State : \(self.checkState)")


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
