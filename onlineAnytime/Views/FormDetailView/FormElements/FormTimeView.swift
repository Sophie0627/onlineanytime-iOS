//
//  FormTimeView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormTimeView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    @State var selectedTime = Date()
    var timeTitle: String
    var id: Int
        
    var body: some View {
        VStack {
            DatePicker(self.timeTitle, selection: $selectedTime, displayedComponents: .hourAndMinute)
                .onChange(of: selectedTime, perform: {selectedTime in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "H:mm"
                    screenInfo.setValues(elementId: "element_\(self.id)", value: formatter.string(from: selectedTime))
                })
                .onAppear(perform: {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "H:mm"
                    screenInfo.setValues(elementId: "element_\(self.id)", value: formatter.string(from: self.selectedTime))
                })
        }
    }
}

struct FormTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FormTimeView(timeTitle: "", id: -1)
    }
}
