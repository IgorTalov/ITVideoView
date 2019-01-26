//
//  ITTimelineView.swift
//  TouchVideoView
//
//  Created by Игорь Талов on 26/01/2019.
//  Copyright © 2019 IgorTalov. All rights reserved.
//

import UIKit

class ITTimelineView: UIView {

    var duration: TimeInterval = 0.0 {
        didSet { setNeedsDisplay() }
    }

    var initialTime: TimeInterval = 0.0 {
        didSet { setNeedsDisplay() }
    }

    var currentTime: TimeInterval = 0.0 {
        didSet { setNeedsDisplay() }
    }

    private var _zoom: CGFloat = 1.0 {
        didSet { setNeedsDisplay() }
    }
    
    var maxZoom: CGFloat = 3.5 {
        didSet { setNeedsDisplay() }
    }
    
    var minZoom: CGFloat = 1.0 {
        didSet { setNeedsDisplay() }
    }
    
    var zoom: CGFloat = 1.0 {
        didSet { setNeedsDisplay() }
    }

    var intervalWidth: CGFloat = 24.0 {
        didSet { setNeedsDisplay() }
    }

    var intervalDuration: CGFloat = 15.0 {
        didSet { setNeedsDisplay() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ITTimelineView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.sublayers?.removeAll()
        let originX: CGFloat = 0.0
        let lineHeight: CGFloat = 4.0
        //Draw Full Line
        let rect = CGRect(x: originX, y: CGFloat(0.0), width: bounds.width, height: lineHeight)
        let totalPath = UIBezierPath(roundedRect: rect, cornerRadius: lineHeight)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = totalPath.cgPath
        shapeLayer.fillColor = UIColor(white: 0.45, alpha: 1.0).cgColor
        layer.addSublayer(shapeLayer)
        //Draw elapsed line
        let elapsedPath = UIBezierPath(roundedRect: CGRect(x: originX, y: 0.0, width: distanceFromTimeInterval(currentTime), height: lineHeight), cornerRadius: lineHeight)
        let elapsedShapeLayer = CAShapeLayer()
        elapsedShapeLayer.path = elapsedPath.cgPath
        elapsedShapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(elapsedShapeLayer)
    }
}

extension ITTimelineView {

    private func currentIntervalWidth() -> CGFloat {
        return intervalWidth * zoom
    }

    func timeIntervalFromDistance(_ distance: CGFloat) -> TimeInterval {
        return TimeInterval(exactly: distance * intervalDuration / currentIntervalWidth())!
    }

    func distanceFromTimeInterval(_ timeInterval: TimeInterval) -> CGFloat {
        return currentIntervalWidth() * CGFloat(timeInterval) / intervalDuration
    }

    func rewindByDistance(_ distance: CGFloat) {
        let newCurrentTime = currentTime + timeIntervalFromDistance(distance)
        currentTime = max(min(newCurrentTime, duration), 0.0)
    }
}
