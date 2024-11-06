import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId = "AddWishCell"

    private let textView = UITextView()
    private let addButton = UIButton(type: .system)
    var addWish: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        selectionStyle = .none
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false

        addButton.setTitle("Add Wish", for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)

        contentView.addSubview(textView)
        contentView.addSubview(addButton)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 80),

            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    @objc private func addWishTapped() {
        guard let wish = textView.text, !wish.isEmpty else { return }
        addWish?(wish)
        textView.text = ""
    }
}
