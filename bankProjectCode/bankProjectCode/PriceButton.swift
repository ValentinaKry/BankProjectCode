import UIKit

class PriceButton: UIButton {

    struct State {
        let id: Int
        let value: Int
        let title: String
        let isHighlighted: Bool
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = CGFloat(Constants.Numbers.radius)
    }
    
    
    func configure(with state: State) {
        setTitle(state.title, for: .normal)
    }
}
