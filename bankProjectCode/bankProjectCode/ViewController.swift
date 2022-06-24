import UIKit

class ViewController: UIViewController {

    private var amountOfMoney = [10, 20, 50, 100]
    private var buttonsStates: [PriceButton.State] = []
    private var selectedAmount : Int? {
            didSet {
                if let amount = selectedAmount {
                    secondLabel.text = title(moneyAmount: amount)
                    let saving = calculateSavings(amountOfMoney: amount)
                    updateTitle(amount: saving)
                }
            }
        }

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private let smallLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var moneyButtons: [UIButton] = {
        var buttons = [UIButton]()

        for state in buttonsStates {
            let button = PriceButton.init(type: .system)
            button.configure(with: state)
            button.addAction(UIAction(handler: { _ in self.selectedAmount = state.value }), for: .primaryActionTriggered)
            buttons.append(button)
        }
        
        

        return buttons
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: moneyButtons)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    private lazy var saveInYear: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()

    func updateTitle(amount: Int?) {
        let attributedString = NSMutableAttributedString()

        attributedString.append(NSAttributedString(string: Constants.String.youSave))
        attributedString.append(
            NSAttributedString(
                string: amount.map(String.init) ?? String(),
                attributes: [
                    .font: UIFont.preferredFont(forTextStyle: .headline),
                    .foregroundColor: Constants.Color.greenColor
                ]
            )
        )
        attributedString.append(NSAttributedString(string: Constants.String.inYear))

        saveInYear.attributedText = attributedString
    }

    private let countButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    func createButton() {
        for i in 0..<amountOfMoney.count {
            let state = PriceButton.State(id: i,
                                          value: amountOfMoney[i],
                                          title: "\(amountOfMoney[i]) ₽",
                                          isHighlighted: false)
            buttonsStates.append(state)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createButton()
        


            //Add Main label (Накопить за 52 недели)
        view.addSubview(mainLabel)
        mainLabel.textColor = Constants.Color.greenColor
        mainLabel.font = UIFont.systemFont(ofSize: CGFloat(Constants.Numbers.mainFontSize))
        mainLabel.text = Constants.String.mainTitle
        firstLabelConstraint()

            //Add Second label (с вопросом)
        view.addSubview(secondLabel)
        secondLabelConstraint()
        secondLabel.font = UIFont.systemFont(ofSize: CGFloat(Constants.Numbers.secondFontSize))
        secondLabel.numberOfLines = Constants.Numbers.numberOfLines
        secondLabel.text = Constants.String.firstQuestion

            //Add small Label (сколько откладывать и увелчивать на)
        view.addSubview(smallLabel)
        smallLabel.text = Constants.String.smallNote
        smallLabel.font = UIFont.systemFont(ofSize: CGFloat(Constants.Numbers.smallFontSize))
        smallLabelConstraint()

            //Add money Button
        view.addSubview(buttonsStackView)
        setUpButtonsStackConstraints()

            //Add label save in Year
        view.addSubview(saveInYear)
        saveInYear.font = UIFont.systemFont(ofSize: CGFloat(Constants.Numbers.secondFontSize))
        saveInYear.numberOfLines = Constants.Numbers.numberOfLines
        updateTitle(amount: nil)
        saveYearConstraint()



            //Add countButton
        view.addSubview(countButton)
        countButton.backgroundColor = Constants.Color.greenColor
        countButton.setTitle(Constants.String.buttonTitle, for: .normal)
        countButton.layer.cornerRadius = CGFloat(Constants.Numbers.radius)
        countButtonConstraint()



    }

        //MARK: - Constraint methods

    func firstLabelConstraint() {
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(Constants.Constraints.mainLabelOffset))
        ])
    }

    func secondLabelConstraint() {
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: CGFloat(Constants.Constraints.smallestOffset)),
            secondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondLabel.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: CGFloat(Constants.Constraints.smallestOffset)),
            secondLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -CGFloat(Constants.Constraints.smallestOffset))
        ])
    }

    func countButtonConstraint() {
        NSLayoutConstraint.activate([
            countButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -CGFloat(Constants.Constraints.buttonOffset)),
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countButton.widthAnchor.constraint(equalToConstant: CGFloat(Constants.Constraints.widhtValue)),
            countButton.heightAnchor.constraint(equalToConstant: CGFloat(Constants.Constraints.heightValue))
        ])
    }

    func setUpButtonsStackConstraints() {
        NSLayoutConstraint.activate([
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(Constants.Constraints.smallestOffset)),
            buttonsStackView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CGFloat(Constants.Constraints.smallestOffset))
        ])
    }

    func smallLabelConstraint() {
        NSLayoutConstraint.activate([
            smallLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -CGFloat(Constants.Constraints.labelYearOffset)),
            smallLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(Constants.Constraints.smallestOffset)),
            smallLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CGFloat(Constants.Constraints.smallestOffset))
        ])

    }

    func saveYearConstraint() {
        NSLayoutConstraint.activate([
            saveInYear.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveInYear.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat(Constants.Constraints.labelYearOffset))
        ])

    }

        //MARK: - Count methods

    private func calculateSavings(amountOfMoney: Int) -> Int {
        return (2 * amountOfMoney + amountOfMoney * 51) / 2 * 52
    }

    private func title(moneyAmount: Int) -> String {
        return "Каждую неделю откладывать на \(moneyAmount) ₽ больше, чем в предыдущую"
    }

    

}

