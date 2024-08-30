// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LoadingViewKit<Content: View>: View {
    
    public let title: String
    @Binding public var isLoading: Bool
    @ViewBuilder public let content: Content
    
    public init(title: String, isLoading: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isLoading = isLoading
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                content
                    .disabled(isLoading)
                    .blur(radius: isLoading ? 3 : 0)
                
                VStack(spacing: 20) {
                    Text(title)
                        .font(.headline)
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                }
                .frame(
                    width: proxy.size.width / 2,
                    height: proxy.size.height / 5
                )
                .background(.background.secondary)
                .foregroundStyle(.primary)
                .cornerRadius(20)
                .opacity(isLoading ? 1 : 0)
            }
        }
    }
}

#Preview {
    LoadingViewKit(title: "Loading...", isLoading: .constant(true)) {
        NavigationStack {
            Text("Content View")
                .navigationTitle("Screen title")
        }
    }
}
