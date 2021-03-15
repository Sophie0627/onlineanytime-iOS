//
//  FormMediaView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FormMediaView: View {
    
    var src: String = ""
    
    var body: some View {
        WebImage(url: URL(string: self.src))
            // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
            .onSuccess { image, data, cacheType in
                // Success
                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
            }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
            .placeholder(Image(systemName: "photo")) // Placeholder Image
            // Supports ViewBuilder as well
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
            .scaledToFit()
            .frame(width: 200, height: 200, alignment: .center)
    }
}

struct FormMediaView_Previews: PreviewProvider {
    static var previews: some View {
        FormMediaView()
    }
}
