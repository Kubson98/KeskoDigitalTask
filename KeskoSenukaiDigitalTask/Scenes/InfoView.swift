//
//  InfoView.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import SwiftUI

struct InfoView: View {
    let action: () -> ()
    let type: InformationType
    var body: some View {
        HStack {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .center, spacing: 2) {
                    Text(type.title)
                        .font(.headline)
                    Button(
                        action: { action() },
                        label: {
                            Text("Refresh")
                        }
                    )
                }
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
            }
            .padding(16)
            .frame(maxWidth: .greatestFiniteMagnitude)
            .foregroundColor(Color.white)
            .cornerRadius(8)
            .multilineTextAlignment(.center)
        }
        .background(type.color)
        .cornerRadius(8)
        .padding()
        .padding(.horizontal, 16)
    }
}

enum InformationType {
    case noData
    case error
    
    var color: Color {
        switch self {
        case .noData:
            return Color(uiColor: UIColor(red: 0.19, green: 0.18, blue: 0.11, alpha: 1.00))
        case .error:
            return .red
        }
    }
    
    var title: String {
        switch self {
        case .noData:
            return "No Data"
        case .error:
            return "Error"
        }
    }
}
