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

    private var outputLabel: UILabel!
    private var phrase1Label: UILabel!
    private var phrase2Label: UILabel!

    private var stackView: UIStackView!
    private(set) var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        phrase1Picker = loadPicker(withTag: 1)
        phrase2Picker = loadPicker(withTag: 2)
        phrase1Label = loadPickerLabel(text: viewModel.phrase1LabelText)
        phrase2Label = loadPickerLabel(text: viewModel.phrase2LabelText)

        outputLabel = loadDetailLabel(with: viewModel.outputMessage)


        loadStackView()

        stackView.addArrangedSubview(phrase1Label)
        stackView.addArrangedSubview(phrase1Picker)
        stackView.addArrangedSubview(phrase2Label)
        stackView.addArrangedSubview(phrase2Picker)
        stackView.addArrangedSubview(outputLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

    }

    public func onCarveButtonPressed() -> GeoMessage {
        return viewModel.geoMessage
    }

    private func loadPicker(withTag tag: Int) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.tag = tag
        return picker
    }

    private func loadDetailLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }

    private func loadPickerLabel(text: String) -> UILabel {
        let label = loadDetailLabel(with: text)
        label.font = .boldSystemFont(ofSize: 18)
        return label
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

// MARK: - PICKER DATASOURCE AND DELEGATE METHODS
extension FormViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return viewModel.phrase1Data.count
        case 2:
            return viewModel.phrase2Data.count
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
            return viewModel.phrase1Data[row]
        case 2:
            return viewModel.phrase2Data[row]
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            viewModel.phrase1 = viewModel.phrase1Data[row]
        case 2:
            viewModel.phrase2 = viewModel.phrase2Data[row]
        default:
            break
        }
        outputLabel.text = viewModel.outputMessage
        viewModel.updateGeoMessage()
    }
}

struct IntegratedFormViewController: UIViewControllerRepresentable {

    private var viewModel: FormViewController.ViewModel

    init(viewModel: FormViewController.ViewModel) {
        self.viewModel = viewModel
    }
    // swiftlint:disable line_length
    func makeUIViewController(context: UIViewControllerRepresentableContext<IntegratedFormViewController>) -> FormViewController {
        let controller = FormViewController(viewModel: viewModel)
        return controller
    }

    func updateUIViewController(_ uiViewController: FormViewController, context: UIViewControllerRepresentableContext<IntegratedFormViewController>) {}
}

struct FormTestView: View {
    var body: some View {
        NavigationView {
            VStack {
                IntegratedFormViewController(viewModel: FormViewController.ViewModel())
            }.navigationTitle("NEW MESSAGE")
        }
    }
}

struct FormTestView_Previews: PreviewProvider {
    static var previews: some View {
        FormTestView()
    }
}
