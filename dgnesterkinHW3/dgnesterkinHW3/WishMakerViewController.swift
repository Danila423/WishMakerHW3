import UIKit

final class WishMakerViewController: UIViewController {
    private var isSlidersHidden = false
    private let stack = UIStackView()
    private let hexTextField = UITextField()
    
    private let sliderRed = CustomSlider(title: "Red", min: 0, max: 255)
    private let sliderGreen = CustomSlider(title: "Green", min: 0, max: 255)
    private let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 255)

    private let toggleButton = UIButton(type: .system)
    private let hexButton = UIButton(type: .system)
    private let randomColorButton = UIButton(type: .system)
    private let addWishButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSliders()
        configureToggleButton()
        configureHexTextField()
        configureHexButton()
        configureRandomColorButton()
        configureAddWishButton()
    }

    private func configureUI() {
        view.backgroundColor = .systemPink
        let title = UILabel()
        title.text = "WishMaker"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        [sliderRed, sliderGreen, sliderBlue].forEach { stack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        sliderRed.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        sliderGreen.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        sliderBlue.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
    }

    private func configureToggleButton() {
        toggleButton.setTitle("Toggle Sliders", for: .normal)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toggleButton)
        toggleButton.addTarget(self, action: #selector(toggleSliders), for: .touchUpInside)
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20)
        ])
    }

    private func configureHexTextField() {
        hexTextField.placeholder = "Enter HEX"
        hexTextField.borderStyle = .roundedRect
        hexTextField.textAlignment = .center
        hexTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hexTextField)
        NSLayoutConstraint.activate([
            hexTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexTextField.topAnchor.constraint(equalTo: toggleButton.bottomAnchor, constant: 20),
            hexTextField.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureHexButton() {
        hexButton.setTitle("Apply HEX Color", for: .normal)
        hexButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hexButton)
        hexButton.addTarget(self, action: #selector(applyHexColor), for: .touchUpInside)
        NSLayoutConstraint.activate([
            hexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexButton.topAnchor.constraint(equalTo: hexTextField.bottomAnchor, constant: 10)
        ])
    }

    private func configureRandomColorButton() {
        randomColorButton.setTitle("Random Color", for: .normal)
        randomColorButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(randomColorButton)
        randomColorButton.addTarget(self, action: #selector(generateRandomColor), for: .touchUpInside)
        NSLayoutConstraint.activate([
            randomColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomColorButton.topAnchor.constraint(equalTo: hexButton.bottomAnchor, constant: 10)
        ])
    }

    private func configureAddWishButton() {
        addWishButton.setTitle("Add Wish", for: .normal)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addWishButton)
        addWishButton.addTarget(self, action: #selector(openWishStoringView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWishButton.topAnchor.constraint(equalTo: randomColorButton.bottomAnchor, constant: 20)
        ])
    }

    @objc private func toggleSliders() {
        isSlidersHidden.toggle()
        stack.isHidden = isSlidersHidden
    }

    @objc private func applyHexColor() {
        guard let hexString = hexTextField.text, let color = UIColor(hexString: hexString) else { return }
        view.backgroundColor = color
    }

    @objc private func generateRandomColor() {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        view.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    @objc private func openWishStoringView() {
        let wishStoringVC = WishStoringViewController()
        present(wishStoringVC, animated: true, completion: nil)
    }

    private func updateBackgroundColor() {
        let redValue = CGFloat(sliderRed.slider.value) / 255
        let greenValue = CGFloat(sliderGreen.slider.value) / 255
        let blueValue = CGFloat(sliderBlue.slider.value) / 255
        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}
