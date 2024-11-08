import AVKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePicturePostImageView: UIImageView!
    @IBOutlet weak var usernamePostLabel: UILabel!
    @IBOutlet weak var contentPostLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isVideoPausedManually = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePicturePostImageView.contentMode = .scaleAspectFill
        self.profilePicturePostImageView.layer.masksToBounds = true
        
        self.contentPostLabel.numberOfLines = 0
        self.contentPostLabel.lineBreakMode = .byWordWrapping
        
        self.mediaImageView.isHidden = true
        self.videoView.isHidden = true
        self.mediaImageView.contentMode = .scaleAspectFill
        self.mediaImageView.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleVideoTap))
        self.videoView.addGestureRecognizer(tapGesture)
        self.videoView.isUserInteractionEnabled = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let minSide = min(self.profilePicturePostImageView.frame.width, self.profilePicturePostImageView.frame.height)
        self.profilePicturePostImageView.layer.cornerRadius = minSide / 2
    }

    func reload(with post: Post) {
        UserService.getUserById(id: post.userId) { [weak self] in
            guard let self = self, let user = UserService.user else {
                return
            }
            self.profilePicturePostImageView.image = UIImage(data: user.profilePicture)
            self.usernamePostLabel.text = "\(user.firstname) \(user.lastname)"
        }
        
        self.contentPostLabel.text = post.content
        
        if let media = post.media {
            let mediaType = getMediaType(from: media)
            if mediaType == .video {
                self.mediaImageView.isHidden = true
                self.videoView.isHidden = false
                let tempDirectory = FileManager.default.temporaryDirectory
                let videoURL = tempDirectory.appendingPathComponent("tempVideo.mp4")
                
                do {
                    try media.write(to: videoURL)
                }
                catch {
                    return
                }
                
                self.player = AVPlayer(url: videoURL)
                self.playerLayer = AVPlayerLayer(player: self.player)
                self.playerLayer?.frame = self.videoView.bounds
                self.videoView.layer.addSublayer(self.playerLayer!)
                
                self.isVideoPausedManually = true
                self.player?.pause()
                
                self.mediaImageView.heightAnchor.constraint(equalToConstant: 0).isActive = false
                self.videoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true

            }
            else if mediaType == .image {
                print("Media is an image, showing mediaImageView")
                self.videoView.isHidden = true
                self.mediaImageView.isHidden = false
                self.mediaImageView.image = UIImage(data: media)
                
                if let image = self.mediaImageView.image {
                    let aspectRatio = image.size.height / image.size.width
                    self.mediaImageView.heightAnchor.constraint(equalTo: self.mediaImageView.widthAnchor, multiplier: aspectRatio).isActive = true
                }
            }
        }
        else {
            self.mediaImageView.isHidden = true
            self.videoView.isHidden = true
            self.mediaImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            self.videoView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    private func getMediaType(from mediaData: Data) -> MediaType {
        if let _ = UIImage(data: mediaData) {
            return .image
        }
        else {
            return .video
        }
    }
    
    @objc private func handleVideoTap() {
        guard let player = player else {
            return
            
        }
        if isVideoPausedManually {
            player.play()
            isVideoPausedManually = false
        }
        else {
            player.pause()
            isVideoPausedManually = true
        }
    }
    
    func ensureVideoPaused() {
        guard let player = player else { return }
        
        if !isVideoPausedManually {
            player.pause()
            isVideoPausedManually = true
        }
    }
    
    func playVideoIfVisible() {
        ensureVideoPaused()
    }
    
    func stopVideoIfNotVisible() {
        ensureVideoPaused()
    }
}
