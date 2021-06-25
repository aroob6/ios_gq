//
//  UserFirebase.swift
//  gqFinal
//
//  Created by bora on 2021/05/21.
//

import Foundation
import  Firebase

extension stampUser {
    static func build(from documents: [QueryDocumentSnapshot]) -> [stampUser] {
           var users = [stampUser]()
           for document in documents {
            users.append(stampUser(name: (document.get("Name") as! String),
                                   stampCount: (document.get("StampCount") as! Int),
                                   profileImg: document.get("Profile_img") as? String
            ))
           }
           return users
       }
}

extension postUser {
    static func build(from documents: [QueryDocumentSnapshot]) -> [postUser] {
           var postusers = [postUser]()
           for document in documents {
            postusers.append(postUser(postTime: (document.get("PostTime") as! Int),
                                      img: (document.get("getImgUri") as! [String]),
                                      uid: (document.get("getUid") as! String),
                                      letter: (document.get("letter") as! String),
                                      name: "",
                                      profileImg: ""
            ))
           }
           return postusers
       }
}
