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
    
    var player: AVPlayer!
    
    var playerLayer: AVPlayerLayer!
    
    var asset: AVURLAsset!
    
    var videoUrl: URL!
    
    var isPlaying = false
    
    var previousLocationX: CGFloat = 0.0
    
    private let rewindDimView = UIVisualEffectView()
    
    private var rewindTimeLineView: ITTimelineView!
    
    convenience init(frame: CGRect, videoUrl: URL) {
        self.init(frame: frame)
        self.videoUrl = videoUrl
        backgroundColor = UIColor.black
        setupGestureRecognizers()
        setupVideoPlayer()
        setupRewindTimeView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension ITVideoView {
    private func setupEffectView() {
        rewindDimView.frame = frame
        addSubview(rewindDimView)
    }
    
    private func setupVideoPlayer() {
        asset = AVURLAsset(url: self.videoUrl)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.frame
        self.layer.addSublayer(playerLayer)
    }
    
    private func setupRewindTimeView() {
        rewindTimeLineView = ITTimelineView(frame: CGRect(x: 0.0, y: 30.0, width: bounds.width, height: 10.0))
        rewindTimeLineView.alpha = 0.0
        let duration = CMTimeGetSeconds(asset.duration)
        rewindTimeLineView.duration = TimeInterval(exactly: duration)!
        addSubview(rewindTimeLineView)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playOrPause))
        addGestureRecognizer(tapGesture)
        
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func playOrPause() {
        if (isPlaying) {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying = !isPlaying
    }
    
    @objc private func longPressed(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        
        if gesture.state == .began {
            player?.pause()
            rewindTimeLineView.currentTime = CMTimeGetSeconds((player.currentItem?.currentTime())!)
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
                self.rewindTimeLineView.alpha = 1.0
            }, completion: nil)
        } else if gesture.state == .changed {
            rewindTimeLineView.rewindByDistance(location.x - previousLocationX)
        } else {
            player?.play()
            let newTime = CMTime(seconds: rewindTimeLineView.currentTime, preferredTimescale: (player.currentItem?.currentTime().timescale)!)
            player.currentItem?.seek(to: newTime)
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
                self.rewindTimeLineView.alpha = 0.0
            }, completion: nil)
        }
        
        if previousLocationX != location.x {
            previousLocationX = location.x
        }
    }
}
