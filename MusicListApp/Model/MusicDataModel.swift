//
//  MusicDataModel.swift
//  MusicListApp
//
//  Created by 石川　太洋 on 2020/02/02.
//  Copyright © 2020 石川　太洋. All rights reserved.
//

import Foundation
import Firebase
import PKHUD

class MusicDataModel {
    
    var artistName:String! = ""
    var musicName:String! = ""
    var preViewURL:String! = ""
    var imageString:String! = ""
    var userID:String! = ""
    var userName:String! = ""
    var artistViewUrl:String! = ""
    var ref:DatabaseReference!
    
    
    var key:String! = ""
    
    init(artistName:String,musicName:String,preViewURL:String,imageString:String,userID:String,userName:String) {
        
        self.artistName = artistName
        self.musicName = musicName
        self.preViewURL = preViewURL
        self.imageString = imageString
        self.userID = userID
        self.userName = userName
        
        //ログインの時に拾えるうuidを先頭につけてす送信、受信する時もuidから引っ張ってくる
        
        ref = Database.database().reference().child("users").child(userID).childByAutoId()
    }
    
    
    init(snapshot:DataSnapshot) {
        
        ref = snapshot.ref
        if let value = snapshot.value as? [String:Any]{
            
            artistName = value["artistName"] as? String
            musicName = value["musicName"] as? String
            preViewURL = value["preViewURL"] as? String
            imageString = value["imageString"] as? String
            userID = value["userID"] as? String
            userName = value["userName"] as? String
            
        }
                
    }
    
    
    func toContents()->[String:Any]{
        
        return ["artistName":artistName!,"musicName":musicName!,"preViewURL":preViewURL!,"imageString":imageString!,"userID":userID!,"userName":userName!]
    }
    
    func save(){
        
        ref.setValue(toContents())
        
    }
    
    
    
}
