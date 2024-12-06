import UIKit
import DGCharts

class StocksViewController: UIViewController {
    let currencySegmentedControl = UISegmentedControl(items: ["USD/AZN", "EUR/AZN", "GBP/AZN"])
    let lineChartView = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


        setupUI()
        updateChartData(for: "USD/AZN")
    }

    func setupUI() {
        currencySegmentedControl.selectedSegmentIndex = 0
        currencySegmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        view.addSubview(currencySegmentedControl)
        view.addSubview(lineChartView)

        currencySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.backgroundColor = .black
        NSLayoutConstraint.activate([
            currencySegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            currencySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currencySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lineChartView.topAnchor.constraint(equalTo: currencySegmentedControl.bottomAnchor, constant: 16),
            lineChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lineChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }

    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let selectedCurrency = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "USD/AZN"
        updateChartData(for: selectedCurrency)
    }

    func updateChartData(for currency: String) {
        let dataEntries = (1...10).map { i -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double.random(in: 15...25))
        }

        let dataSet = LineChartDataSet(entries: dataEntries, label: "\(currency) Exchange Rates")
        dataSet.colors = [NSUIColor.blue]
        dataSet.circleColors = [NSUIColor.red]

        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
    }
}

