//
//  FormSectionView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/18/21.
//

import SwiftUI

struct FormSectionView: View {
    
    var sectionTitle: String = ""
    var sectionGuideline: String = ""
//    var id: Int = -1
    
    var body: some View {
        VStack{
            Text(self.sectionTitle)
            Text(self.sectionGuideline)
        }
        
    }
}

struct FormSectionView_Previews: PreviewProvider {
    static var previews: some View {
        FormSectionView()
    }
}
