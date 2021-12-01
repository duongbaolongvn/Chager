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
    var percentage: Double = 0
    
    
    var buttonPath = UIBezierPath()
    override func draw(_ rect: CGRect) {
        if didLoad {return}
        didLoad = true
        
        self.layer.addSublayer(maxCircle)
        self.layer.addSublayer(percentageCircle)
        dragView.layer.addSublayer(dragRound)
        dragView.layer.addSublayer(button)
        self.layer.addSublayer(minCircle)
        self.layer.addSublayer(text)
        self.addSubview(dragView)
        
        let frame = CGRect(x: 0, y: 0, width: 280, height: 280)
        dragView.frame = frame
        dragView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panSiler(_:))))
        dragView.isUserInteractionEnabled = true
        initView()
    }
    func initView() {
        drawMaxCircle()
        drawDragRound(0)
        drawMinCircle()
        drawPercentageCircle(0)
        drawText(0)
        drawButton()
    }
    func drawMaxCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: 140, startAngle: 0, endAngle: .pi*2, clockwise: true)
        maxCircle.path = circlePath.cgPath
        
        maxCircle.fillColor = UIColor(red: 225/255, green: 233/255, blue: 253/255, alpha: 1).cgColor
        
    }
    func drawMinCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: 50, startAngle: 0, endAngle: .pi*2, clockwise: true)
        minCircle.path = circlePath.cgPath
        
        minCircle.fillColor = UIColor.white.cgColor
        
    }
    func drawPercentageCircle(_ percentage: Double) {
        let value = percentage*90 + 50
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: value, startAngle: 0, endAngle: .pi*2, clockwise: true)
        percentageCircle.path = circlePath.cgPath
        
        percentageCircle.fillColor = UIColor(red: 80/255, green: 130/255, blue: 247/255, alpha: 1).cgColor
    }
    func drawDragRound(_ percentage: Double) {
        let roundPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2,y: bounds.height/2), radius: 144, startAngle: -.pi/2, endAngle: .pi*2*CGFloat(percentage) - .pi/2, clockwise: true)
        dragRound.path = roundPath.cgPath
        
        dragRound.lineCap = .round
        dragRound.backgroundColor = .none
        dragRound.fillColor = UIColor.clear.cgColor
        dragRound.strokeColor = UIColor(red: 90/255, green: 132/255, blue: 255/255, alpha: 1).cgColor
        dragRound.lineWidth = 10
    }
    func drawButton() {
        buttonPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: 0), radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
        button.path = buttonPath.cgPath
        
        button.lineWidth = 5
        button.strokeColor = UIColor.blue.cgColor
        button.fillColor = UIColor.white.cgColor
    }
    func drawText(_ percentage: Double) {
        let frame = CGRect(x: bounds.width/2 - 50, y: bounds.height/2 - 25, width: 100, height: 50)
        text.frame = frame
        
        text.string = "\(Int(percentage*100))%"
        text.foregroundColor = UIColor(red: 80/255, green: 130/255, blue: 244/255, alpha: 1).cgColor
        text.font = UIFont.systemFont(ofSize: 0, weight: .bold)
    }
    @objc func panSiler(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {return}
        
        let point = sender.location(in: view)
        let buttonX = Double(point.x)
        let buttonY = Double(point.y)
        let midViewX = Double(bounds.width/2)
        let midViewY = Double(bounds.height/2)
        let angleX = buttonX - midViewX
        let angleY = buttonY - midViewY
        let angle = atan2(angleX, angleY)
        let buttonX2 = midViewX + sin(angle)*140
        let buttonY2 = midViewY + cos(angle)*140
        
        let newPerentage = (Double.pi - angle)/(Double.pi*2)
        
        if abs(newPerentage - percentage) > 0.5 {
            percentage = percentage < 0.5 ? 0 : 1
        } else {
            percentage = newPerentage
        }
        drawDragRound(percentage)
        if percentage == 0 {
            drawDragRound(0)
            drawText(0)
        } else if percentage == 1 {
            drawDragRound(1)
            drawText(1)
        } else {
            drawDragRound(percentage)
            drawPercentageCircle(percentage)
            drawText(percentage)
            
            buttonPath = UIBezierPath(arcCenter: CGPoint(x: buttonX2, y: buttonY2), radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
            button.path = buttonPath.cgPath
        }
        
    }
}
