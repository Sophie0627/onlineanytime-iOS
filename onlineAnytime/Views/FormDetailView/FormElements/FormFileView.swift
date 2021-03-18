//
//  FormFileView.swift
//  onlineAnytime
//
//  Created by Sophie on 3/14/21.
//

import SwiftUI

struct FormFileView: View {
    
    var fileTitle: String
    var id: Int
    @State private var isShowPhotoLibrary = false
    @State private var isClickButton = false
    @State private var image = UIImage()
    @EnvironmentObject var screenInfo: ScreenInfo
    
    var body: some View {
        VStack {
            Text(self.fileTitle.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)).fixedSize(horizontal: false, vertical: true)
            
            Button(action: {
                self.isShowPhotoLibrary = true
                self.isClickButton = true
            }) {
                Text("SELECT FILE")
            }.padding()
            
            if isClickButton {
                Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                    .onChange(of: image, perform: {image in
                        let imageData = image.pngData()
                        let imageBase64String: String = imageData?.base64EncodedString() ?? ""
                        self.screenInfo.setValues(elementId: "file[element_\(self.id)]", value: "\(imageBase64String.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.replacingOccurrences(of: "+", with: "%2B"))")
                    })
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}

struct FormFileView_Previews: PreviewProvider {
    static var previews: some View {
        FormFileView(fileTitle: "", id: -1)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
