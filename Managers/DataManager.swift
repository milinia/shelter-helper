//
//  DataManager.swift
//  project
//
//  Created by Evelina on 17.03.2022.
//

import Foundation
import MapKit
import FirebaseFirestore

class DataManager {
    
    func getShelters(completion: @escaping ((Result<QuerySnapshot?, Error>)->Void)){
        let db = Firestore.firestore()
        let sheltersRef = db.collection("shelter")
        
        sheltersRef.getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(error!))
            }else{
                completion(.success(querySnapshot))
            }
        }
    }
    
    func getShelterNeeds(shelterId: String, completion: @escaping ((Result<QuerySnapshot?, Error>)->Void)){
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(shelterId).collection("needs")
        
        needsRef.getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(error!))
            }else{
                completion(.success(querySnapshot))
            }
        }
    }
    
//    func updateShelterNeed(shelterId: String, needNumber: Int, need: Need, completion: @escaping ((Result<QuerySnapshot?, Error>)->Void)){
//        let db = Firestore.firestore()
//        let needsRef = db.collection("shelter").document(shelterId).collection("needs").document("\(needNumber)")
//        needsRef.updateData([
//            "collectedAmount": need.
//        ])
//    }
}
