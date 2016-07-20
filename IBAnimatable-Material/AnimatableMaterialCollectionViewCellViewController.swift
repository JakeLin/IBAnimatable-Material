//
//  AnimatableMaterialCollectionViewCellViewController.swift
//  IBAnimatable-Material
//
//  Created by George Kye on 2016-07-19.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import Material

class AnimatableMaterialCollectionViewCellViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  private lazy var menuView: MenuView = MenuView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareMenuViewExample()
  }
  
  /// Handle the menuView touch event.
  internal func handleMenu() {
    if menuView.menu.opened {
      menuView.menu.close()
      (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0))
    } else {
      menuView.menu.open() { (v: UIView) in
        (v as? MaterialButton)?.pulse()
      }
      (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0.125))
    }
  }
  
  /// Handle the menuView touch event.
  @objc(handleButton:)
  internal func handleButton(button: UIButton) {
    print("Menu Button was tapped")
  }
  

  /// Prepares the MenuView example.
  private func prepareMenuViewExample() {
    var image: UIImage? = MaterialIcon.cm.audio
    let btn1: FabButton = FabButton()
    btn1.setImage(image, forState: .Normal)
    btn1.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
    menuView.addSubview(btn1)
    
    image = MaterialIcon.image
    let btn2: FabButton = FabButton()
    btn2.setImage(image, forState: .Normal)
    btn2.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
    menuView.addSubview(btn2)
    
    
    image = MaterialIcon.share
    let btn3: FabButton = FabButton()
    btn3.setImage(image, forState: .Normal)
    btn3.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
    menuView.addSubview(btn2)
    
    // Initialize the menu and setup the configuration options.
    menuView.menu.direction = .Up
    menuView.menu.baseSize = CGSizeMake(56,56)
    menuView.menu.views = [btn1, btn2, btn3]
    
    view.layout(menuView).width(100).height(100).bottom(40).right()
    self.collectionView?.bringSubviewToFront(menuView)
  }
  

  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DemoCollectionViewCell
    cell.startColor = UIColor.randomColor()
    cell.endColor = UIColor.randomColor()
    
    if indexPath.row % 3 == 0 {
      cell.slideInLeft()
    }else{
      cell.pop()
    }
    
    return cell
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 200)
  }
  
  
}


class DemoCollectionViewCell: AnimatableMaterialCollectionViewCell{
  
}


//MARK: Generate random color
extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}

extension UIColor {
  static func randomColor() -> UIColor {
    return UIColor(red:   .random(),
                   green: .random(),
                   blue:  .random(),
                   alpha: 1.0)
  }
}