//
//  UserService.swift
//  gqFinal
//
//  Created by bora on 2021/05/21.
//

import Foundation
import Firebase

class UserService {
    let database = Firestore.firestore()

    func get(collectionID: String, handler: @escaping ([stampUser]) -> Void) {
        database.collection(collectionID).order(by: "StampCount", descending: true)
            .addSnapshotListener { querySnapshot, err in
                if let error = err {
                    print(error)
                    handler([])
                } else {
                    handler(stampUser.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
}

class PostUserService {
    let database = Firestore.firestore()

    func get(collectionID: String, handler: @escaping ([postUser]) -> Void) {
        database.collection(collectionID).order(by: "postNum", descending: true)
            .addSnapshotListener { querySnapshot, err in
                if let error = err {
                    print(error)
                    handler([])
                } else {
                    handler(postUser.build(from: querySnapshot?.documents ?? []))
                }
                
            }
    }
}
