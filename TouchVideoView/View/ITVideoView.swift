//
//  ITVideoView.swift
//  TouchVideoView
//
//  Created by Игорь Талов on 26/01/2019.
//  Copyright © 2019 IgorTalov. All rights reserved.
//

import UIKit
import AVFoundation

class ITVideoView: UIView {
    
    var player: AVPlayer?
    var videoUrl: URL?
    var isPlaying = false
    
    convenience init(frame: CGRect, videoUrl: URL) {
        self.init(frame: frame)
        self.videoUrl = videoUrl
        backgroundColor = UIColor.black
        setupGestureRecognizers()
        setupVideoPlayer()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupVideoPlayer() {
        player = AVPlayer(url: videoUrl as! URL)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.frame
        self.layer.addSublayer(playerLayer)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playOrPause))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func playOrPause() {
        if (isPlaying) {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying = !isPlaying
    }
    
    @objc private func detectSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
    }
    
}

extension ITVideoView {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches
        print(touches)
    }
    
    
    
}
