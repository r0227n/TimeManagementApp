//
//  InitalScreenViewModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/20.
//

import SwiftUI

struct InitialScreenViewModel: View {
    @EnvironmentObject var viewModel: RecordViewModel
    var body: some View {
        switch viewModel.switchViewController {
        case 0:
            TimeStartView()
        case 1:
            TimeRecordView()
        case 2:
            TimePauseView()
        default:
            TimeStartView()
        }
    }
}

struct InitalScreenViewModel_Previews: PreviewProvider {
    static var previews: some View {
        InitialScreenViewModel()
    }
}
