//
//  CloudKitHelper.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 10/11/1445 AH.
//

import CloudKit
import SwiftUI

class CloudKitHelper: ObservableObject {
    @Published var images: [UIImage] = []

    private var database: CKDatabase
    
    init() {
        self.database = CKContainer.default().publicCloudDatabase
        fetchImages()
    }
    
    func fetchImages() {
        let query = CKQuery(recordType: "ImageRecord", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error fetching records: \(error)")
                return
            }
            
            guard let records = records else { return }
            
            for record in records {
                if let asset = record["image"] as? CKAsset, let fileURL = asset.fileURL {
                    if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.images.append(image)
                        }
                    }
                }
            }
        }
    }
}

