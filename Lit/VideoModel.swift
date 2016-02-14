//
//  VideoModel.swift
//  Lit
//
//  Created by Yehuda Lelah on 2/13/16.
//  Copyright © 2016 Yehuda Lelah. All rights reserved.
//

import Foundation
import Alamofire

//protocol VideoModelDelegate {
//    func dataReady()
//}

class VideoModel: NSObject {
    let API_KEY = "AIzaSyBpkbClOVLwuFohX5LGf3vcqq0mGhA48ys"
    let PLAYLIST_ID = "PLMWfZxj1nTkREjGseQuSmkRKmFYeombUq"
    
    var search: String?
    var videoArray = [String]()
    // var delegate : VideoModelDelegate?
    var defaults : NSUserDefaults?
    
    func getVideo(callback: () -> Void) {
        Alamofire.request(.GET, "https://www.googleapis.com/youtube/v3/search", parameters: ["part":"snippet", "q":search!, "maxResults":20, "type":"video" ,"key":API_KEY], encoding: .URL, headers: nil).responseJSON { (response) -> Void in
            if let JSON = response.result.value {
                var videosArray = [String]()
                
                for video in JSON["items"] as! NSArray {
                    print(video)
                    
                    // Create Video Object
                    let videoObject = Video()
                    videoObject.videoID = video.valueForKeyPath("id.videoId") as! String
                    
                    videosArray.append(videoObject.videoID)
                }
                
                print("setting videos array defaults")
                self.videoArray = videosArray
                self.defaults = NSUserDefaults.standardUserDefaults()
                self.defaults?.setObject(videosArray, forKey: "videoArray")
//                if self.delegate != nil {
//                    self.delegate?.dataReady()
//                }
                
                callback()
                
                print("finished setting")
            }
        }
    }
}