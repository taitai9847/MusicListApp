//
//  SelectViewController.swift
//  MusicListApp
//
//  Created by Fujii Yuta on 2019/12/11.
//  Copyright © 2019 Fujii Yuta. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import SDWebImage
import PKHUD
import Firebase
import ChameleonFramework


class SelectViewController: UIViewController,VerticalCardSwiperDelegate,VerticalCardSwiperDatasource {
    
    //受け取り用
    var artistNameArray = [String]()
    var musicNameArray = [String]()
    var previewURLArray = [String]()
    var imageStringArray = [String]()
    
    var indexNumber = Int()
    var userID = String()
    var userName = String()
    
    //右にスワイプ好きなものを入れる配列
    var likeArtistNameArray = [String]()
    var likeMusicNameArray = [String]()
    var likePreviewURLArray = [String]()
    var likeImageStringArray = [String]()
    var likeArtistViewUrlArray = [String]()
    
    
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib:UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
        
        cardSwiper.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        
        return artistNameArray.count
        
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: index) as? CardViewCell {
            
            
            verticalCardSwiperView.backgroundColor = UIColor.randomFlat()
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            
            
            //セル(カード)に配列を表示させる
            let artistName = artistNameArray[index]
            let musicName =  musicNameArray[index]
            cardCell.setRandomBackgroundColor()
            cardCell.artistNameLabel.text = artistName
            cardCell.artistNameLabel.textColor = UIColor.white
            cardCell.musicNameLabel.text = musicName
            cardCell.musicNameLabel.textColor = UIColor.white
            
            cardCell.artWorkImageView.sd_setImage(with: URL(string: imageStringArray[index]), completed: nil)
            
            return cardCell
            
            
        }
        
        return CardCell()
        
    }
    
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        artistNameArray.remove(at: index)
        musicNameArray.remove(at: index)
        previewURLArray.remove(at: index)
        imageStringArray.remove(at: index)
        
    }

    
    
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        
        indexNumber = index
        
        if swipeDirection == .Right{
            //右にスワイプしたときに好きなものとして、新しい配列に入れてあげる
            likeArtistNameArray.append(artistNameArray[indexNumber])
            likeMusicNameArray.append(musicNameArray[indexNumber])
            likePreviewURLArray.append(previewURLArray[indexNumber])
            likeImageStringArray.append(imageStringArray[indexNumber])
            
            if likeArtistNameArray.count != 0 && likeMusicNameArray.count != 0 && likePreviewURLArray.count != 0 && likeImageStringArray.count != 0{
                
                let musicDataModel = MusicDataModel(artistName: artistNameArray[indexNumber], musicName: musicNameArray[indexNumber], preViewURL: previewURLArray[indexNumber], imageString: imageStringArray[indexNumber], userID: userID, userName: userName)
                
                
                musicDataModel.save()
            }
            
        }
    
    }


    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
