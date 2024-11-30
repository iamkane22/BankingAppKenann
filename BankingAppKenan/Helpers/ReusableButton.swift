import UIKit

class ReusableButton: UIButton {
    private var onaction: () -> Void
    private var color: UIColor?

    init(title: String, color: UIColor, onaction: @escaping () -> Void) {
        self.onaction = onaction
        self.color = color
        super.init(frame: .zero)
        setupUI(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(title: String) {
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        backgroundColor = color
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
    }

    @objc private func buttonTapped() {
        onaction()
    }
}

