//
//  AlbumView.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import UIKit

class AlbumView:UIView {
    
    private let coverImageView:UIImageView = {
        let imv = UIImageView(frame: .zero)
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    private let indicatorView:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(frame: .zero)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.activityIndicatorViewStyle = .whiteLarge
        return aiv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(frame: CGRect, coverUrl:String) {
        super.init(frame: frame)
        commonInit()
        NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView": coverImageView, "coverUrl": coverUrl])
    }
    
    private func commonInit() {
        backgroundColor = .black
        
        addSubview(coverImageView)
        indicatorView.startAnimating()
        addSubview(indicatorView)
        
        coverImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func highlightAlbum(_ didHightLightView: Bool) {
        backgroundColor = didHightLightView == true ? .white : .black
    }
}
