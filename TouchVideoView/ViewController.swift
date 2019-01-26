//
//  ViewController.swift
//  TouchVideoView
//
//  Created by Игорь Талов on 26/01/2019.
//  Copyright © 2019 IgorTalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoView()
    }

    func setupVideoView() {
        let path = Bundle.main.path(forResource: "bladerunner-2049-trailer-2_h480p", ofType: "mov")
        let videoUrl = URL(fileURLWithPath: path!)
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 350)
        let videoView = ITVideoView(frame: rect, videoUrl: videoUrl)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(videoView)
        
        videoView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        videoView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

