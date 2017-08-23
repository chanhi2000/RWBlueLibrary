//
//  AlbumTableViewCell.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    let categoryLabel:UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .left
        lbl.font = UIFont.systemFont(ofSize: 17)
        return lbl
    }()
    
    let detailLabel:UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .right
        lbl.font = UIFont.systemFont(ofSize: 17)
        return lbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(categoryLabel)
        addSubview(detailLabel)
        setupViews()
    }
    
    private func setupViews() {
        categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        detailLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    
}
