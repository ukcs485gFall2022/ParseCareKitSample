//
//  CustomCardView.swift
//  OCKSample
//
//  Created by Corey Baker on 12/3/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import CareKitUI
import CareKitStore

struct CustomCardView: View {
    @Environment(\.careKitStyle) var style
    @StateObject var viewModel: CustomCardViewModel

    var body: some View {
        CardView {
            VStack(alignment: .leading,
                   spacing: style.dimension.directionalInsets1.top) {
                /*
                 // Example of custom content that looks something like Header.
                 TODO: Remove this if you don't use it.
                 VStack(alignment: .leading, spacing: style.dimension.directionalInsets1.top / 4.0) {
                    Text(viewModel.taskEvents.firstEventTitle)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(viewModel.taskEvents.firstEventDetail ?? "")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundColor(Color.primary)
                Divider() */
                // Can look through HeaderView for creating custom
                HeaderView(title: Text(viewModel.taskEvents.firstEventTitle),
                           detail: Text(viewModel.taskEvents.firstEventDetail ?? ""))
                HStack(alignment: .top,
                       spacing: style.dimension.directionalInsets2.trailing) {

                    /*
                     // Example of custom content.
                     TODO: Remove all that you are not using.
                     */
                    VStack(alignment: .leading) {
                        Text("Text...")
                    }

                    CircularCompletionView(isComplete: viewModel.taskEvents.isFirstEventComplete) {
                        Image(systemName: "checkmark") // Can place any view type here
                            .resizable()
                            .padding()
                            .frame(width: 50, height: 50) // Change size to make larger/smaller
                    }

                    Spacer()

                    RectangularCompletionView(isComplete: viewModel.taskEvents.isFirstEventComplete) {
                        Image(systemName: "checkmark") // Can place any view type here
                            .resizable()
                            .padding()
                            .frame(width: 50, height: 50) // Change size to make larger/smaller
                    }

                    Text("\(viewModel.taskEvents.firstEventOutcomeValueInt)")
                        .multilineTextAlignment(.trailing)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
        .careKitStyle(style)
    }
}

struct CustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCardView(viewModel: .init(storeManager: .init(wrapping: OCKStore(name: Constants.noCareStoreName,
                                                                               type: .inMemory))))
    }
}
