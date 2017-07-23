//
//  ViewController.swift
//  FB-livestream-animation
//
//  Created by siddharth bhalla on 7/23/17.
//  Copyright © 2017 sb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numberPerView = 15
    var cells = [String: UIView]()

    @IBOutlet weak var bgImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background grids
        let width = view.frame.width / CGFloat(numberPerView)
        for j in 0...26{
            for i in 0...numberPerView{
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderWidth = 1
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }


        // animates when user taps on screen
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // for handling multiple images for animation
    func handleTap() {
        (0...8).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
      fileprivate  func generateAnimatedViews() {
            // Sets the image to be animated at top left corner
            let img = drand48() > 0.5 ? #imageLiteral(resourceName: "mario") : #imageLiteral(resourceName: "Johnny_Bravo")
            let imageView = UIImageView(image: img)
            let dimension = 80 + drand48() * 10
            imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
            
            // animates the image over the path of customPath
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.path = customPath().cgPath
            animation.duration = 2 + drand48() * 3
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            
            imageView.layer.add(animation, forKey: nil)
            view.addSubview(imageView)
        }
    
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x:0, y:200))  // Starting point for stroking
    let endPoint = CGPoint(x: 500, y: 150)  // Ending point for stroking
    let randomYShifter = 200 + drand48() * 300
    let cp1 = CGPoint(x: 100, y: 100 - randomYShifter)
    let cp2 = CGPoint(x: 200, y: 700 + randomYShifter)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        //does some fancy curve drawing
        
        // BezierPath is a set of line segments that can potentially have curvces to it
        let path = customPath()
        path.lineWidth = 3
        
        path.stroke()
    }
    
    

}




