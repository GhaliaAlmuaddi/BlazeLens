//
//  ImagePicker.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import SwiftUI

import CloudKit
import MobileCoreServices

struct ImagePicker: View {
    @State private var image: Image?
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showSuccessAlert = false
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }

            Button("Select Image") {
                showImagePicker = true
            }
            .padding()

            Button("Save Image to CloudKit") {
                saveImageToCloudKit()
            }
            .padding()
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Image saved successfully!"),
                    dismissButton: .default(Text("OK")) {
                        // Dismiss the presentation mode (ImagePicker)
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerRepresentable(selectedImage: $selectedImage)
        }
    }

    private func saveImageToCloudKit() {
        guard let selectedImage = selectedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            return
        }

        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        do {
            try imageData.write(to: fileURL)
        } catch {
            print("Error writing image data to file: \(error.localizedDescription)")
            return
        }

        let asset = CKAsset(fileURL: fileURL)
        let record = CKRecord(recordType: "YourRecordType")
        record["imageField"] = asset

        CKContainer.default().privateCloudDatabase.save(record) { (_, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error saving image to CloudKit: \(error.localizedDescription)")
                } else {
                    showSuccessAlert = true
                }
            }
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?

        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = uiImage
            }

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerRepresentable>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeImage as String]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerRepresentable>) {}
}



#Preview {
    ImagePicker()
}
