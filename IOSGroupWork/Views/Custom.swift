//
//  Custom.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 16/4/25.
//

import SwiftUICore
import SwiftUI

struct NavBarBackground: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        Rectangle()
            .fill(Color.navigationBarBlue)
            .frame(maxWidth: .infinity)
            .frame(height: barHeight)
    }
    
    private var barHeight: CGFloat {
        verticalSizeClass == .compact ? 65 : 100
    }
}

struct CustomButton: View {
    let title: String
    let action: () -> Void
    let disabledCondition: Bool
    let alertConfig: AlertConfig?
    
    @State private var showAlert = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(minWidth: 110, maxHeight: 40)
                .background(Color.white)
                .foregroundColor(.customBlue)
                .cornerRadius(10)
        }
        .disabled(disabledCondition)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertConfig?.title ?? ""),
                message: Text(alertConfig?.message ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct AlertConfig {
    let title: String
    let message: String
}
