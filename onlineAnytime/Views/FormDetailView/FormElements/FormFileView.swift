//
//  FormFileView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormFileView: View {
    
    var fileTitle: String
    
    var body: some View {
        VStack {
            Text(self.fileTitle.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
            Button(action: {}) {
                Text("SELECT FILE")
            }.padding()
        }
    }
}

struct FormFileView_Previews: PreviewProvider {
    static var previews: some View {
        FormFileView(fileTitle: "")
    }
}
