//
//  FormView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import SwiftUI

struct FormView: View {
    @ObservedObject private var viewModel = FormViewController.ViewModel()

    var didAddMessage: (_ geoMesage: GeoMessage) -> Void

    var body: some View {
            VStack {
                IntegratedFormViewController(viewModel: viewModel)

                Button("Engrave Into World") {
                    didAddMessage(viewModel.geoMessage)
                }
            }
    }
}
