//
//  FormDetailView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/11/21.
//

import SwiftUI

struct FormDetailView: View {
    
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        VStack(spacing: 0.0) {
            Color.green.overlay(
                HStack(content: {
                    Button(action: {
                        self.screenInfo.screenInfo = "home"
                    }) {
                        Image("back_icon").padding()
                    }
                    Text(self.screenInfo.formName).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading)
                    Text("Submit").foregroundColor(.white).padding()
                })
            ).frame(height: 60)
            Text(self.screenInfo.formName).frame(maxWidth: .infinity).padding()
            Text(self.screenInfo.formDescription).frame(maxWidth:. infinity).padding()
            Spacer()
        }
    }
}

struct FormDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FormDetailView()
    }
}
