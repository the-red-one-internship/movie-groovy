import UIKit

class PosterCell: UICollectionViewCell {
    var imageView: UIImageView!
    var caption: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Create an ImageView and add it to the collection view
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 177, height: 213))
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        // Create a label view
        let textFrame = CGRect(x: 0, y: 0, width: 177, height: 21)
        caption = UILabel(frame: textFrame)
        caption.font = UIFont.systemFont(ofSize: 17.0)
        caption.textAlignment = .left
        caption.numberOfLines = 2
        contentView.addSubview(caption)
    }
}
