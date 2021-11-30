import UIKit




class CircleDrag: UIView {
    
    var didLoad = false
    var dragView = UIView()
    var button = CAShapeLayer()
    var minCircle = CAShapeLayer()
    var maxCircle = CAShapeLayer()
    var percentageCircle = CAShapeLayer()
    var text = CATextLayer()
    var dragRound = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        if didLoad {return}
        didLoad = true
        
        self.layer.addSublayer(maxCircle)
        self.layer.addSublayer(minCircle)
        self.layer.addSublayer(percentageCircle)
        dragView.layer.addSublayer(dragRound)
        dragView.layer.addSublayer(button)
        self.layer.addSublayer(text)
        
        self.addSubview(dragView)
        dragView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dra))
    }
    
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        
    }
}
