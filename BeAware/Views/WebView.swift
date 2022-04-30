//import SwiftUI
//import WebKit
//
//struct WebView: NSViewRepresentable {
//
//    var url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//}
import SwiftUI
import WebKit

struct WebView: View {
    @Binding var url: URL
    
    var body: some View {
        WebViewWrapper(url: url)
    }
}

struct WebViewWrapper: NSViewRepresentable {
    var url: URL
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        nsView.load(request)
        //nsView.loadHTMLString(html, baseURL: nil)
    }
}
