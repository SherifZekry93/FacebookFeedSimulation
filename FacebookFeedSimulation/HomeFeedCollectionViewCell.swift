//
//  HomeFeedCollectionViewCell.swift
//  FacebookFeedSimulation
//
//  Created by Sherif  Wagih on 9/11/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()
class HomeFeedCollectionViewCell: UICollectionViewCell {
    
    var homeController:ViewController?
    @objc func animateImage()
    {
       homeController?.animateImage(
        statusImageView)
    }

    var post:Post?{
        didSet{
            if let postName = post?.name
            {
                let attributedText = NSMutableAttributedString(string: postName, attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 0.2, alpha: 1)])
                
                attributedText.append(NSAttributedString(string: "\nCreated By Him in 2010", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
                attributedText.append(NSAttributedString(attachment: attachment))
                nameLabel.attributedText = attributedText

            }
            if let statusText = post?.statusText
            {
                statusTextView.text = statusText
            }
            if let profileImage = post?.profImageName
            {
                profileImageView.image = UIImage(named: profileImage)
            }
            if let statusImage = post?.postStatusImageUrl
            {
                if let url = URL(string: statusImage)
                {
                    if let imageFromCache = imageCache.object(forKey: url as AnyObject)
                    {
                        print("downloading from cache")
                        statusImageView.image = imageFromCache as? UIImage
                        activityIndicator.stopAnimating()
                        return
                    }
                    
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if error != nil
                        {
                            return
                        }
                        print("downloading from server")
                        DispatchQueue.main.async {
                            let imageToCache = UIImage(data: data!)
                            imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                            self.statusImageView.image = imageToCache
                            self.activityIndicator.stopAnimating()
                        }
                    }.resume()
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
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
    let statusTextView:UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
       // textView.text = "Meanwhile beast turned to the dark side"
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    let statusImageView:UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        //imageV.image = UIImage(named: "zuckdog")
        imageV.backgroundColor = .white
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleAspectFill
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    let likeCommentsLabel:UILabel = {
       let lclabel = UILabel()
        lclabel.text = "488 Likes  10.7k Comments"
        lclabel.translatesAutoresizingMaskIntoConstraints = false
        lclabel.font = UIFont.systemFont(ofSize: 16)
        lclabel.textColor = .gray
        return lclabel
    }()
    
    let separator:UIView = {
       let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return sep
    }()
    
    let likeButton:UIButton = {
       let button = UIButton()
      //  button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Like", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "like"), for: .normal)
        //button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 2)
        return button
    }()
    
    let commentButton:UIButton = {
        let button = UIButton()
        button.setTitle("Comment", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 3)
        return button
    }()
    
    let shareButton:UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 2)
        //button.backgroundColor = .red
        return button
    }()
    lazy var controlsStackView : UIStackView = {
       let stacView = UIStackView(arrangedSubviews: [self.likeButton,self.commentButton,self.shareButton])
        stacView.translatesAutoresizingMaskIntoConstraints = false
        stacView.distribution = .fillEqually
        return stacView
    }()
    let activityIndicator = UIActivityIndicatorView()
    func setupViews() {
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
        
        addSubview(statusTextView)
         addSubview(statusImageView)
        NSLayoutConstraint.activate([
            statusTextView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            statusTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
          //  statusTextView.bottomAnchor.constraint(equalTo: statusImageView.topAnchor,constant:8)
            ])
      // statusTextView.backgroundColor = .red
        NSLayoutConstraint.activate([
            statusImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            statusImageView.heightAnchor.constraint(equalToConstant: 200),
            statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 8)
            ])
        addSubview(likeCommentsLabel)
        NSLayoutConstraint.activate([
            likeCommentsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant:10),
            likeCommentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            likeCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8),
            likeCommentsLabel.heightAnchor.constraint(equalToConstant: 25)
            ]
        )
        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor,constant:10),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            separator.topAnchor.constraint(equalTo: likeCommentsLabel.bottomAnchor, constant: 3),
            separator.heightAnchor.constraint(equalToConstant: 1)
            ]
        )
      
        addSubview(controlsStackView)
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
       // controlsStackView.backgroundColor = .red
        NSLayoutConstraint.activate([
            controlsStackView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            controlsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant:0),
            controlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            controlsStackView.bottomAnchor.constraint(equalTo:bottomAnchor),
            controlsStackView.heightAnchor.constraint(equalToConstant: 40)
            ])
       // likeButton.backgroundColor = .red
        statusImageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //activityIndicator.backgroundColor = .red
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        //addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: statusImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40),
            ]
        )
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateImage)))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
