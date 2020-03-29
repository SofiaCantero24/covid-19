//
//  MarkerView.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/22/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class MarkerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMarkerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMarkerView() {
        let markerView = UIView()
        markerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        markerView.clipsToBounds = true
        markerView.layer.cornerRadius = frame.height / 2
        markerView.layer.borderWidth = 1
        markerView.layer.borderColor = UIColor.markerBorder.cgColor
        markerView.backgroundColor = .markerFill
        addSubview(markerView)
        backgroundColor = .clear
    }
}
