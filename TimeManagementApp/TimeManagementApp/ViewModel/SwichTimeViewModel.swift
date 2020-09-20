//
//  SwichTimeViewModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/20.
//

import SwiftUI

struct SwichTimeViewModel: View {
    @EnvironmentObject var viewModel: RecordViewModel
    var body: some View {
        if(viewModel.switchViewController){
            TimeRecordView().navigationBarHidden(true)
        }else{
            TimePauseView().navigationBarHidden(true)
        }
    }

}

struct SwichTimeViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SwichTimeViewModel()
    }
}
