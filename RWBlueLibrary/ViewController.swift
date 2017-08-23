//
//  ViewController.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import UIKit

public let tableViewCellIdentifier = "cellid"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let undoBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: nil)
    let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let trashBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
    
    lazy var tableView:UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        navigationItem.title = "Pop Music"

        navigationController?.isToolbarHidden = false
//        navigationController?.toolbar.setItems([undoBarButtonItem, flexibleSpace, trashBarButtonItem], animated: false)
        // above line is deprecated so we have to use this line below instead
        toolbarItems = [undoBarButtonItem, flexibleSpace, trashBarButtonItem]
        navigationController?.toolbar.isUserInteractionEnabled = true
        
        
        view.addSubview(tableView)
        setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }

    fileprivate func setupViews() {
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 320).isActive = true
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

