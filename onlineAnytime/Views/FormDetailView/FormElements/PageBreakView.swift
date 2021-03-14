//
//  PageBreakView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct PageBreakView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        HStack {
            Button(action: {
                self.screenInfo.pageNumber += 1
            }) {
                Text("CONTINUE")
            }
            if self.screenInfo.pageNumber > 1 {
                Button(action: {
                    self.screenInfo.pageNumber -= 1
                }) {
                    Text("PREVIOUS")
                }
            }
        }
    }
}

struct PageBreakView_Previews: PreviewProvider {
    static var previews: some View {
        PageBreakView()
    }
}
