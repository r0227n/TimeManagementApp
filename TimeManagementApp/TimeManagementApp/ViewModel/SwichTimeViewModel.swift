//
//  SwichTimeViewModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/20.
//

import SwiftUI

struct SwichTimeViewModel: View {
    @EnvironmentObject var viewModel: RecordViewModel
    @State var check:Bool = true
    var body: some View {
        ZStack {
            TimeStartView()
                .opacity(viewModel.timeViewSwitch == 1 ? 1 : 0)
                .offset(x : viewModel.timeViewSwitch == 1 ? 0 : 100)
                .animation(.default)
            TimeRecordView()
                .opacity(viewModel.timeViewSwitch == 2 ? 1 : 0)
                .offset(x : viewModel.timeViewSwitch == 2 ? 0 : 100)
                .animation(.default)
                .navigationBarHidden(true)
            
            TimePauseView()
                .opacity(viewModel.timeViewSwitch == 3 ? 1 : 0)
                .offset(x : viewModel.timeViewSwitch == 3 ? 0 : 100)
                .animation(.easeOut)
                
        }
        
    }
    private func reset(){
                            viewModel.elapsedHour = 0
                            viewModel.elapsedMinute = 0
                            viewModel.elapsedSecond = 0
    }

}

struct SwichTimeViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SwichTimeViewModel()
    }
}
