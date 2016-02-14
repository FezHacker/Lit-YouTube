//
//  ViewController.swift
//  Lit
//
//  Created by Yehuda Lelah on 2/13/16.
//  Copyright © 2016 Yehuda Lelah. All rights reserved.
//

import UIKit
import XCDYouTubeKit

class ViewController: UIViewController {
    
    var model = VideoModel()

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    var cellVideo: Video?
    var video: [Video] = [Video]()

    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func searchTextAction(sender: AnyObject) {
        // print(self.searchText.text)
    }
    
    @IBAction func searchTextEnd(sender: AnyObject) {
        print(self.searchText.text!)
        self.model.search = self.searchText.text!
        print("the search var is \(self.model.search)")
        
        // getVideo callback to call the finish
        self.model.getVideo { () -> Void in
            self.finish()
        }
    
    }
    
    // Create the View and the VideoPlayer for YouTube videos
    func finish() {
        self.defaults = NSUserDefaults.standardUserDefaults()
        let videoArray = self.defaults.objectForKey("videoArray")
        if let video = videoArray?.objectAtIndex(0) as? String {
            print(video)
            
            // Setting width and hight + add new View for VideoPlayer
            let width = self.view.frame.size.width
            let height = width / 320 * 180
            let videoView = UIView(frame: CGRectMake(0, height / 4.0, width, height))
            self.view.addSubview(videoView)
            
            // YouTube VideoPlayer
            let videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: video)
            videoPlayerViewController.presentInView(videoView)
            videoPlayerViewController.moviePlayer.play()
        } else {
            print("there is nothing to set on web view")
            print(self.cellVideo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
