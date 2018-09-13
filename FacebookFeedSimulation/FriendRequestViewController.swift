//
//  FriendRequestViewController.swift
//  FacebookFeedSimulation
//
//  Created by Sherif  Wagih on 9/12/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class FriendRequestViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let profileCellId = "cellId"
    var posts:[Post]  = []
    let headerViewCellId = "headerViewCell"
    var allPosts  = [
    [Post](),
    [Post]()
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        allPosts[0].append(Post(name: "Mark Zuckerberg",statusText:"Here is something I wanna tell all of you guys facebook sucks",profImageName:"zuckprofile",postStatusImageUrl:"https://tinyjpg.com/images/social/website.jpg"))
        allPosts[1].append(Post(name: "Ghandi ",statusText:"I created apple a long time ago and I'm not sure why but this company sucks and it only cares about the money and not any of it's clients",profImageName:"gandhi_profile",postStatusImageUrl:"https://tinyjpg.com/images/social/website.jpg"))
        allPosts[1].append(Post(name: "Steve Jobs",statusText:"I created apple a long time ago and I'm not sure why but this company sucks and it only cares about the money and not any of it's clients and here is the rest of the text that we can append should still be working fine I guess",profImageName:"steve_profile",postStatusImageUrl:"https://tinyjpg.com/images/social/website.jpg"))
        
        view.backgroundColor = .yellow
        navigationItem.title = "Friend Requests"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let flowlayout =  collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flowlayout.sectionInset = UIEdgeInsets.zero;
        flowlayout.minimumInteritemSpacing = 10
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.register(RequestFeedCollectionViewCell.self, forCellWithReuseIdentifier: profileCellId)
        collectionView?.register(HeaderForCollectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewCellId)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts[section].count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath) as! RequestFeedCollectionViewCell
        let allPostss = allPosts[indexPath.section] 
        cell.nameLabel.text = allPostss[indexPath.item].name
        cell.profileImageView.image = UIImage(named: "zuckprofile")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //print(indexPath.section)
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewCellId, for: indexPath) as! HeaderForCollectionView
        cell.titleLabel.text = indexPath.section == 0 ? "Friend Requests" : "People you may know!"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class RequestFeedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        imageView.image = UIImage(named: "zuckprofile")
        return imageView
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    func setupViews()
    {
        addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            profileImageView.heightAnchor.constraint(equalToConstant: 44),
            profileImageView.widthAnchor.constraint(equalToConstant: 44)
            ])
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor,constant:8),
            ])
    }
}
class HeaderForCollectionView:UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant:5),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
}
