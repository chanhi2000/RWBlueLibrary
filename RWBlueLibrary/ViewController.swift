//
//  ViewController.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import UIKit

private enum Constants {
    static let tableViewCellIdentifier = "cell"
}

class ViewController: UIViewController, UITableViewDelegate {

    private let undoBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: nil)
    private let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    private let trashBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
    
    lazy var horizontalScrollerView:HorizontalScrollerView = {
        let hsv = HorizontalScrollerView(frame: .zero)
        hsv.translatesAutoresizingMaskIntoConstraints = false
        hsv.delegate = self
        hsv.dataSource = self
        return hsv
    }()
    
    var currentAlbumIndex = 0
    var currentAlbumData:[AlbumData]?
    var allAlbums = [Album]()
    
    lazy var tableView:UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Pop Music"

        navigationController?.isToolbarHidden = false
//        navigationController?.toolbar.setItems([undoBarButtonItem, flexibleSpace, trashBarButtonItem], animated: false)
        // above line is deprecated so we have to use this line below instead
        toolbarItems = [undoBarButtonItem, flexibleSpace, trashBarButtonItem]
        navigationController?.toolbar.isUserInteractionEnabled = true
        
        allAlbums = LibraryAPI.shared.getAlbums()
        
        view.addSubview(tableView)
        view.addSubview(horizontalScrollerView)
        setupViews()
        
        horizontalScrollerView.reload()
        showDataForAlbum(at: currentAlbumIndex)
        
    }

    fileprivate func setupViews() {
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: horizontalScrollerView.bottomAnchor).isActive = true
        
        horizontalScrollerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalScrollerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalScrollerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        horizontalScrollerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    fileprivate func showDataForAlbum(at index:Int) {
        // defensive code: make sure the requested index is lower than the amount of albums
        if (index < allAlbums.count && index > -1) {
            let album = allAlbums[index]        // fetch the album
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumData = currentAlbumData else {  return 0 }
        return albumData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as! AlbumTableViewCell
        if let albumData = currentAlbumData {
            let row = indexPath.row
            cell.categoryLabel.text = albumData[row].title
            cell.detailLabel.text = albumData[row].value
        }
        return cell
    }
}

extension ViewController: HorizontalScrollerViewDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
        let previousAlbumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(false)
        currentAlbumIndex = index
        
        let albumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
        albumView.highlightAlbum(true)
        
        showDataForAlbum(at: index)
    }
}

extension ViewController: HorizontalScrollerViewDataSource {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
        return allAlbums.count
    }
    
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x:0, y:0, width:100, height:100), coverUrl: album.coverUrl)
        albumView.highlightAlbum(currentAlbumIndex == index ? true : false)
        return albumView
    }
}

