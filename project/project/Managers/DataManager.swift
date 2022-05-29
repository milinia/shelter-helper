//
//  DataManager.swift
//  project
//
//  Created by Evelina on 17.03.2022.
//

import Foundation
import MapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class DataManager {
    
    
    func updateShelterLastNeedNumber(shelterId: String, number: Int) {
        let db = Firestore.firestore()
        let shelterRef = db.collection("shelter").document(shelterId)

        shelterRef.updateData([
            "lastNeedNumber": number
        ])
//        shelterRef.updateData([
//            "lastNeedNumber": number
//        ]) { error in
//
//        }
    }
    func updateShelterLastAnimalPhoto(shelterId: String, number: Int) {
        let db = Firestore.firestore()
        let shelterRef = db.collection("shelter").document(shelterId)
        
        shelterRef.updateData([
            "lastAnimalPhotoId": number
        ])
//        shelterRef.updateData([
//            "lastAnimalPhotoId": number
//        ]) { error in
//        }
    }
    func getShelters(completion: @escaping ((Result<QuerySnapshot?, Error>) -> Void)) {
        let db = Firestore.firestore()
        let sheltersRef = db.collection("shelter")
        
        sheltersRef.getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(querySnapshot))
            }
        }
    }
    func getShelter(shelterId: String, completion: @escaping ((Result<DocumentSnapshot?, Error>) -> Void)) {
        let db = Firestore.firestore()
        let shelterRef = db.collection("shelter").document(shelterId)
        
        shelterRef.getDocument { docSnapshot, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(docSnapshot))
            }
        }
    }
    func getShelterNeeds(shelterId: String, completion: @escaping ((Result<QuerySnapshot?, Error>) -> Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(shelterId).collection("needs")
        
        needsRef.getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(querySnapshot))
            }
        }
    }
    func getShelterAnimals(shelterId: String, completion: @escaping ((Result<QuerySnapshot?, Error>) -> Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(shelterId).collection("animals")
        
        needsRef.getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(querySnapshot))
            }
        }
    }
    func getShelterAnimalPhoto(shelterId: String, imageName: String, completion: @escaping ((Result<UIImage?, Error>) -> Void)) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child(shelterId).child(imageName + ".jpg")
        
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(UIImage(data: data!)))
            }
        }
    }
    func updateShelterNeed(needNumber: Int, need: Need, payment: Int, completion: @escaping ((Result<String, Error>) -> Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(need.shelterId).collection("needs").document("\(needNumber)")
        needsRef.updateData([
            "collected_amount": need.collectedAmount + payment
        ]) { error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(""))
            }
        }
    }
    func addNeed(needTitle: String, requiredAmount: Int, shelterId: String, lastNeedNumber: Int, completion: @escaping ((Result<String, Error>) -> Void)) {
        let db = Firestore.firestore()
        let needsRef = db.collection("shelter").document(shelterId).collection("needs")
                        .document("\(lastNeedNumber + 1)")
        needsRef.setData([
            "title": needTitle,
            "collected_amount": 0,
            "required_amount": requiredAmount
        ]) { error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(""))
            }
        }
    }
    func addAnimal(animal: Animal, shelterId: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        let db = Firestore.firestore()
        let animalRef = db.collection("shelter").document(shelterId).collection("animals")

        animalRef.addDocument(data: [
            "title": animal.title,
            "about": animal.text,
            "image_id": animal.imageNames
        ]) { error in
            if error != nil {
                completion(.failure(error!))
            } else {
                completion(.success(""))
            }
        }
    }
    func uploadAnimalPhoto(image: UIImage, shelterId: String, imageName: String,
                           completion: @escaping ((Result<String?, Error>) -> Void)) {
        let storageRef = Storage.storage().reference().child(shelterId).child(imageName + ".jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        if let imageBuf : Data = image.jpegData(compressionQuality: 1.0) {
            let uploadTask = storageRef.putData(imageBuf, metadata: metadata) { metadata, error in
                if error != nil {
                    completion(.failure(error!))
                } else {
                    completion(.success(nil))
                }
            }
        }
    }
    func addUserCreditCard(card: Card, cardsNumber: Int, completion: @escaping ((Result<String, Error>) -> Void)) {
        if let userId = Auth.auth().currentUser?.uid {
            let ref: DatabaseReference! = Database.database(url: "https://shelter-helper-160bf-default-rtdb.europe-west1.firebasedatabase.app/").reference()
            ref.child(userId).child("cards").child("\(cardsNumber + 1)").setValue([
                "code": card.code,
                "number": card.number,
                "owner": card.owner,
                "validityPeriod": card.validityPeriod
            ]) { error, dbref in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(""))
                }
            }
            
        }
    }
}
