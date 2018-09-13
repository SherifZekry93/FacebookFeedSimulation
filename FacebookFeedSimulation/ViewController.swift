//
//  ViewController.swift
//  FacebookFeedSimulation
//
//  Created by Sherif  Wagih on 9/11/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let postCellId = "cellId"
    var posts:[Post]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        posts.append(Post(name: "Mark Zuckerberg",statusText:"Here is something I wanna tell all of you guys facebook sucks",profImageName:"zuckprofile",postStatusImageUrl:"https://tinyjpg.com/images/social/website.jpg"))
        posts.append(Post(name: "Ghandi ",statusText:"I created apple a long time ago and I'm not sure why but this company sucks and it only cares about the money and not any of it's clients",profImageName:"gandhi_profile",postStatusImageUrl:"https://tinyjpg.com/images/social/website.jpg"))
        posts.append(Post(name: "Steve Jobs",statusText:"I created apple a long time ago and I'm not sure why but this company sucks and it only cares about the money and not any of it's clients and here is the rest of the text that we can append should still be working fine I guess",profImageName:"steve_profile",postStatusImageUrl:"https://tinyjpg.com/images/social/website.jpg"))
        view.backgroundColor = .yellow
        navigationItem.title = "Facebook Feed"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let flowlayout =  collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flowlayout.sectionInset = UIEdgeInsets.zero;
        flowlayout.minimumInteritemSpacing = 10
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.register(HomeFeedCollectionViewCell.self, forCellWithReuseIdentifier: postCellId)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellId, for: indexPath) as! HomeFeedCollectionViewCell
        cell.post = posts[indexPath.item]
        cell.homeController = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let statusText = posts[indexPath.item].statusText else
        { return CGSize(width:view.frame.width , height: 390)}
                
            let size = CGSize(width:view.frame.width ,height:1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedRect = NSString(string: statusText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
            let height = 370 + estimatedRect.size.height
            return CGSize(width:view.frame.width , height: height)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    let blackBGview = UIView()
    var originalStatusImageView : UIImageView?
    let detailsView = UIImageView()
    let activeWindow = UIApplication.shared.keyWindow
    func animateImage(_ statusImage:UIImageView)
    {
        blackBGview.frame = activeWindow!.frame
        blackBGview.backgroundColor = .black
        UIApplication.shared.keyWindow?.addSubview(blackBGview)
        blackBGview.alpha = 0
        
        if let startingFrame = statusImage.superview?.convert(statusImage.frame, to: collectionView?.superview?.superview)
        {
            statusImage.alpha = 0
            detailsView.backgroundColor = .red
            detailsView.frame = startingFrame
            detailsView.image = statusImage.image
            detailsView.isUserInteractionEnabled = true
            detailsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOutHandle)))
            activeWindow?.addSubview(detailsView)
            UIView.animate(withDuration: 0.5) {
                self.blackBGview.alpha = 1
                self.detailsView.frame = CGRect(x: 0, y:(self.activeWindow?.frame.height)! / 2 - self.detailsView.frame.height / 2, width: self.detailsView.frame.width, height: self.detailsView.frame.height)
//                self.detailsView.alpha = 1
            }
            originalStatusImageView = statusImage
        }
     }
    @objc func zoomOutHandle()
    {
        if let startingFrame = originalStatusImageView?.superview?.convert((originalStatusImageView?.frame)!, to: collectionView?.superview?.superview)
        {
            
          
            UIView.animate(withDuration: 0.5, animations: {
                self.blackBGview.alpha = 1
                self.detailsView.frame = CGRect(x: startingFrame.origin.x, y:startingFrame.origin.y, width: self.self.detailsView.frame.width, height: self.self.detailsView.frame.height)
                self.originalStatusImageView?.alpha = 1
                self.blackBGview.alpha = 0
            }) { (completed) in
                self.detailsView.removeFromSuperview()
                self.blackBGview.removeFromSuperview()
            }
            
            
            
            
        }
    }
}

