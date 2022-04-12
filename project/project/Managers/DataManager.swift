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
    
    func getShelterNeeds(shelterId: String, completion: @escaping ((Result<QuerySnapshot?, Error>)->Void)) {
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
    
    func getShelterAnimals(shelterId: String, completion: @escaping ((Result<QuerySnapshot?, Error>)->Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(shelterId).collection("animals")
        
        needsRef.getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(error!))
            }else{
                completion(.success(querySnapshot))
            }
        }
    }
    
    func updateShelterNeed(needNumber: Int, need: Need, payment: Int, completion: @escaping ((Result<String,Error>)->Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(need.shelterId).collection("needs").document("\(needNumber)")
        
        needsRef.updateData([
            "collectedAmount": need.collectedAmount + payment
        ]) { error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(""))
            }
        }
    }
    
    func addNeed(need: Need, lastNeedNumber: Int, completion: @escaping ((Result<String,Error>)->Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(need.shelterId).collection("needs")
        
        needsRef.addDocument(data: [
            "title": need.title,
            "collected_amount": 0,
            "required_amount": need.requiredAmount
        ]) { error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(""))
            }
        }
    }
    
//    func addAnimal(need: Need, lastNeedNumber: Int, completion: @escaping ((Result<String,Error>)->Void)) {
//        let db = Firestore.firestore()
//        let needsRef = db.collection("shelter").document(need.shelterId).collection("animals")
//
//        needsRef.addDocument(data: [
//            "title": need.title,
//            "collected_amount": 0,
//            "required_amount": need.requiredAmount
//        ]) { error in
//            if error != nil {
//                completion(.failure(error!))
//            } else {
//                completion(.success(""))
//            }
//        }
//    }
}
