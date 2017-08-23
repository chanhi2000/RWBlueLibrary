//
//  HorizontalScrollerView.swift
//  RWBlueLibrary
//
//  Created by LeeChan on 8/23/17.
//  Copyright © 2017 MarkiiimarK. All rights reserved.
//

import UIKit

protocol HorizontalScrollerViewDataSource: class {
    // Ask the data source how many views it wants to present inside the horizontal scroller
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int
    // Ask the data source to return the view that should appear at <index>
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView
}

protocol HorizontalScrollerViewDelegate: class {
    // inform the delegate that the view at <index> has been selected
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int)
}

class HorizontalScrollerView: UIView {
    weak var dataSource: HorizontalScrollerViewDataSource?
    weak var delegate: HorizontalScrollerViewDelegate?
    
    private enum ViewConstants {
        static let Padding:CGFloat = 10
        static let Dimensions:CGFloat = 100
        static let Offset:CGFloat = 100
    }
    
    private lazy var scroller:UIScrollView = {
        let scv = UIScrollView()
        scv.delegate = self
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollerTapped(gesture:))))
        return scv
    }()
    
    private var contentViews = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeScrollView()
    }
    
    fileprivate func initializeScrollView() {
        backgroundColor = .lightGray
        addSubview(scroller)
        scroller.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        scroller.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        scroller.topAnchor.constraint(equalTo: topAnchor).isActive=true
        scroller.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    func scrollToView(at index:Int, animated:Bool = true) {
        /*
            retrieve the view for a specific index and centers it
         */
        let centralView = contentViews[index]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        scroller.setContentOffset(CGPoint(x:targetOffsetX, y:0), animated: animated)
    }
    
    func scrollerTapped(gesture: UITapGestureRecognizer) {
        /* 
            find the location of the tap in the scrollview, inform the delegate,
            then scroll the view to the center
         */
        let location = gesture.location(in: scroller)
        guard let index = contentViews.index(where: {  $0.frame.contains(location)  }) else {  return  }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
        scrollToView(at: index)
    }
    
    func view(at index:Int) -> UIView {
        return contentViews[index]
    }
    
    func reload() {
        /*
            reload all the data used to construct the horizonal scroller
         */
        
        guard let dataSource = dataSource else {  return  }
        
        contentViews.forEach({  $0.removeFromSuperview()  })  //remove the old content
        
        var xValue = ViewConstants.Offset
        contentViews = (0..<dataSource.numberOfViews(in: self)).map { index in
            xValue += ViewConstants.Padding
            let view = dataSource.horizontalScrollerView(self, viewAt: index)
            view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.Padding, width: ViewConstants.Dimensions, height: ViewConstants.Dimensions)
            scroller.addSubview(view)
            xValue += ViewConstants.Dimensions + ViewConstants.Padding
            return view
        }
        scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.Offset),
                                      height: frame.size.height)
    }
    
    func centerCurrentView() {
        let centerRect = CGRect(
            origin: CGPoint(x: scroller.bounds.midX - ViewConstants.Padding, y: 0),
            size: CGSize(width: ViewConstants.Padding, height: bounds.height)
        )
        guard let selectedIndex = contentViews.index(where: {  $0.frame.intersects(centerRect)  }) else {  return  }
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetoffsetX = targetCenter.x - (scroller.bounds.width/2)
        
        scroller.setContentOffset(CGPoint(x: targetoffsetX, y:0), animated: true)
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
    }
}

extension HorizontalScrollerView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}

