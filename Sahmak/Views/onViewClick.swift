import UIKit

// MARK: ClickListener
class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}


// MARK: UIView Extension
extension UIView {
    
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
  
}
