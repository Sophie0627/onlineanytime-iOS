//
//  FormDateView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormDateView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    @State var selectedDate = Date()
    var dateTitle: String
    var id: Int
        
    var body: some View {
        VStack {
            DatePicker(self.dateTitle, selection: $selectedDate, displayedComponents: .date)
                .onChange(of: selectedDate, perform: {selectedDate in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    screenInfo.setValues(elementId: "element_\(self.id)", value: formatter.string(from: selectedDate))
                })
                .onAppear(perform: {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    screenInfo.setValues(elementId: "element_\(self.id)", value: formatter.string(from: self.selectedDate))
                })
        }
    }
}

struct FormDateView_Previews: PreviewProvider {
    static var previews: some View {
        FormDateView(dateTitle: "", id: -1)
    }
}
