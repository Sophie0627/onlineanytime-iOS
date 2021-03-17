//
//  FormTimeView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormTimeView: View {
    @State var selectedTime = Date()
    var timeTitle: String
    var id: Int
        
    var body: some View {
        VStack {
            DatePicker(self.timeTitle, selection: $selectedTime, displayedComponents: .hourAndMinute)
        }
    }
}

struct FormTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FormTimeView(timeTitle: "", id: -1)
    }
}
