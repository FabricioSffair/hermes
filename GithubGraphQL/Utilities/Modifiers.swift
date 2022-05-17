//
//  Modifiers.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-17.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

struct AutoShrink: ViewModifier {
    
    let lineLimit: Int
    let minScaleFactor: CGFloat
    
    func body(content: Content) -> some View {
        content
            .lineLimit(lineLimit)
            .minimumScaleFactor(minScaleFactor)
    }
}

struct RefreshableList: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .refreshable {
                    action()
                }
        } else {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            action()
                        } label: {
                            Images.HomeView.refreshIcon
                                .foregroundColor(.blue)
                        }
                    }
                }
        }
    }
}


extension View {
    
    func autoShrink(lineLimit: Int = 1, minScaleFactor: CGFloat = 0.8) -> some View {
        modifier(AutoShrink(lineLimit: lineLimit, minScaleFactor: minScaleFactor))
    }
    
    func refreshableLists(_ action: @escaping () -> Void) -> some View {
        modifier(RefreshableList(action: action))
    }
}
