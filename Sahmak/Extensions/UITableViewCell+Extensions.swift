import UIKit
import Nuke

extension UITableViewCell {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func loadImage(stringUrl: String, placeHolder: UIImage?, imgView: UIImageView) {
        if !stringUrl.isEmpty, let url = URL(string: stringUrl) {
            let options = ImageLoadingOptions(
                placeholder: placeHolder,
                transition: .fadeIn(duration: 0.0),
                failureImage: placeHolder
            )
            Nuke.loadImage(with: url, options: options, into: imgView)
        }
    }
    
    public static var cellId: String {
        return String(describing: self)
    }
    
    public static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    public static var nib: UINib {
        return UINib(nibName:  self.cellId, bundle: self.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
    }
}

