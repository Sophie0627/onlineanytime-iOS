//
//  FormDateView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormDateView: View {
    @State var selectedDate = Date()
    var dateTitle: String
    var id: Int
        
    var body: some View {
        VStack {
            DatePicker(self.dateTitle, selection: $selectedDate, displayedComponents: .date)
        }
    }
}

struct FormDateView_Previews: PreviewProvider {
    static var previews: some View {
        FormDateView(dateTitle: "", id: -1)
    }
}
