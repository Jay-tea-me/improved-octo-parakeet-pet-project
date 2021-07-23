//
//  FormViewController.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/23.
//

import UIKit
import SwiftUI

class FormViewController: UIViewController {

    private var phrase1Picker: UIPickerView!
    private var phrase2Picker: UIPickerView!

    private var locationLabel: UILabel!
    private var outputLabel: UILabel!
//    private var carveButton: UIButton!
    private var stackView: UIStackView!

    private let phrase1Data = ["A", "B", "C", "D"]
    private let phrase2Data = ["0", "1", "2", "3"]

    private var phrase1 = "A"
    private var phrase2 = "0"

    override func viewDidLoad() {

        super.viewDidLoad()
        loadPhrase1Picker()
        loadPhrase2Picker()
        loadOutputLabel()
        loadLocationLabel()
        loadStackView()

        stackView.addArrangedSubview(phrase1Picker)
        stackView.addArrangedSubview(phrase2Picker)
        stackView.addArrangedSubview(outputLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

    }

    private func loadPhrase1Picker() {
        phrase1Picker = UIPickerView()
        phrase1Picker.dataSource = self
        phrase1Picker.delegate = self
        phrase1Picker.tag = 1
    }

    private func loadPhrase2Picker() {
        phrase2Picker = UIPickerView()
        phrase2Picker.dataSource = self
        phrase2Picker.delegate = self
        phrase2Picker.tag = 2
    }

    private func loadLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = "COORDINATES: (0, 0)"
    }

    private func loadOutputLabel() {
        outputLabel = UILabel()
        outputLabel.text = "MESSAGE: A 0"
    }

    private func loadStackView() {
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 20
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // dispose
    }
}

//MARK: - PICKER DATASOURCE AND DELEGATE METHODS
extension FormViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return phrase1Data.count
        case 2:
            return phrase2Data.count
        default:
            return 1
        }
    }

    // number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // return data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return phrase1Data[row]
        case 2:
            return phrase2Data[row]
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            phrase1 = phrase1Data[row]
        case 2:
            phrase2 = phrase2Data[row]
        default:
            break
        }
        outputLabel.text = "MESSAGE: \(phrase1) \(phrase2)"
    }
}

struct IntegratedFormViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<IntegratedFormViewController>) -> FormViewController {
        let controller = FormViewController()
        return controller
    }

    func updateUIViewController(_ uiViewController: FormViewController, context: UIViewControllerRepresentableContext<IntegratedFormViewController>) {}

}
struct FormTestView: View {
    var body: some View {
        NavigationView {
            IntegratedFormViewController()
        }
    }
}

struct FormTestView_Previews: PreviewProvider {
    static var previews: some View {
        FormTestView()
    }
}
