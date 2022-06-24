//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import SwiftUI
import StoreKit

struct SettingsView : View {
    @State private var showShareSheet = false
    @State private var showRateSheet = false
    // TODO: FIGURE THIS OUT
//    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var body : some View {
        ZStack{
            Color("BrandColor")
            VStack {
                List(infoItems) { item in
                    if item.name == NSLocalizedString("Share", comment: "Share")
                    {
                        Button(action: {
                            self.showShareSheet.toggle()
                        }) {
                            InfoRow(infoItem: item)
                        }
                    }
                    else if item.name == NSLocalizedString("Rate The App", comment: "Rate The App")
                    {
                        Button(action: {
                            self.showRateSheet.toggle()
                        }) {
                            InfoRow(infoItem: item)
                        }
                    }
                    // TODO: FIGURE THIS OUT
//                    else if  MFMailComposeViewController.canSendMail() && item.name == "Contact Us"
//                    {
//                        Button(action: {
//                            self.isShowingMailView.toggle()
//                        }) {
//                            InfoRow(infoItem: item)
//                        }
//                    }
                    else{
                        NavigationLink{
                            switch item.name{
//                            case NSLocalizedString("Video", comment:"Video"):
//                                VideoView()
                            case NSLocalizedString("Tutorial", comment: "Tutorial"):
                                TutorialView()
                            case NSLocalizedString("About Us", comment: "About"):
                                AboutView()
                            case NSLocalizedString("Widget", comment: "Widget"):
                                WidgetView()
                                // Just in case sharing is not available?
                            case NSLocalizedString("Share", comment: "Share"):
                                WidgetView()
                                // TODO: Figure it out
//                            case NSLocalizedString("Contact Us", comment: "Contact Us"):
//                                WebView(url: URL(string: "https://forms.gle/RbQxn7ymAAHWGSoy8")!).navigationTitle(NSLocalizedString("CONTACT US", comment: "CONTACT US"))
//                            case NSLocalizedString("License Agreement", comment: "License Agreement"):
//                                WebView(url: URL(string: "https://github.com/philparkus/BeAware/blob/main/LICENSE")!).navigationTitle(NSLocalizedString("LICENSE AGREEMENT", comment: "LICENSE AGREEMENT"))
//                            case NSLocalizedString("Terms Of Use", comment: "Terms Of Use"):
//                                WebView(url: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!).navigationTitle(NSLocalizedString("TERMS OF USE", comment: "TERMS OF USE"))
//                            case NSLocalizedString("Privacy Policy", comment: "Privacy Policy"):
//                                WebView(url: URL(string: "https://deafassistant.com/privacy-policy.html")!).navigationTitle(NSLocalizedString("PRIVACY POLICY", comment: "PRIVACY POLICY"))
                            default:
                                //TODO: Figure this out
                                AboutView()
//                                VideoView()
                            }
                        } label:{
                            InfoRow(infoItem: item)
                        }
                    }
                }
                Spacer ()
            }
        }.navigationTitle("INFO")
        // TODO: FIGURE THIS OUT

//            .navigationBarTitleTextColor(Color("SecondaryColor"))
        // TODO: Change this when we are getting rid of iOS 14 support
            .alert(isPresented: $showRateSheet, content: {
                Alert(
                    title: Text(NSLocalizedString("Do you like this app?", comment: "Do you like this app?")),
                    primaryButton: .default(Text("Yes"), action: {
                        print("Pressed")
                        // TODO: FIGURE THIS OUT
//                        if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
                    }),
                    secondaryButton: .destructive(Text("Not"))
                )
            })
            .sheet(isPresented: $showShareSheet) {
                // TODO: FIGURE THIS OUT
//                ShareSheet(activityItems: [NSLocalizedString("Hi! I downloaded BeAware- the Deaf assistant for iPhones and I really think you should check it out. You can install a special free version through here: https://deafassistant.com/app", comment: "ShareSheet")])
                    }
            .sheet(isPresented: $isShowingMailView) {
                // TODO: FIGURE THIS OUT

//                MailView(isShowing: self.$isShowingMailView, result: self.$result)
            }
    }
}
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
