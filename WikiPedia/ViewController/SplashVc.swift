//
//  SplashVc.swift
//  WikiPedia
//
//  Created by Magna on 29/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//

import UIKit

class SplashVc: UIViewController {
    @IBOutlet weak var img_logo: UIImageView!
      var animator  = UIDynamicAnimator()
    override func viewDidLoad() {
        super.viewDidLoad()
        applyMotionEffect(toView: img_logo, magnitude: +100)
    }
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.perform(#selector(pushToNextSplash), with: nil, afterDelay: 1.0)
    }
    @objc func pushToNextSplash(){
            let loViewController:WikiSearchVC? = self.storyboard?.instantiateViewController(withIdentifier: "WikiSearchVC") as! WikiSearchVC?
            self.navigationController?.pushViewController(loViewController!, animated: true)
        }
    func applyMotionEffect (toView view:UIView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        view.addMotionEffect(group)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
