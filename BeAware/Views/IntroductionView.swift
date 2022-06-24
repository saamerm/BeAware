//
//  ContentView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/2/22.
//

import SwiftUI

struct IntroductionView: View {
    @AppStorage("DidShowIntroductionView") var isActive:Bool = false
//    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    @Environment(\.openURL) var openURL

    var body: some View {
        if self.isActive {
            // 3.
            MyTabView()
        }
        else{
            ZStack{
                    Color("BrandColor")
                        .ignoresSafeArea()
                ScrollView{
                    VStack{
                        Spacer()
                        Text("Welcome to BeAware")
                            .font(Font.custom("Avenir", size: 18))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("SecondaryColor"))
                            .padding()

                        Text("This app has 4 main functions:")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding()
                                
                        VStack(alignment: .leading){
                            HStack{
                                Text("\(Image(systemName: "bell.and.waveform.fill")) ")
                                    .foregroundColor(Color("SecondaryColor"))
                                Text(NSLocalizedString("Alert - Turn your device into an elite alerting tool with customizable alerts of short or prolonged sounds around you", comment: "ALERT") + "\n") // TODO: Use idiom instead of device
                                    .font(Font.custom("Avenir", size: 18))
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            HStack{
                                Text("\(Image(systemName: "mic")) ")
                                    .foregroundColor(Color("SecondaryColor"))
                                
                                Text(NSLocalizedString("Speech - Take advantage of your phone's powerful speech-to-text capability to transcribe, even while the app is in the background", comment: "Speech") + "\n")
                                    .font(Font.custom("Avenir", size: 18))
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            HStack{
                                Text("\(Image(systemName: "keyboard")) ")
                                    .foregroundColor(Color("SecondaryColor"))
                                Text(NSLocalizedString("Text - BeAware is the only app that can read text loud into your live phone calls, assisted by customizable preset phrases", comment: "Text") + "\n")
                                    .font(Font.custom("Avenir", size: 18))
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            HStack{
                                Text("\(Image(systemName: "checkerboard.rectangle")) ")
                                    .foregroundColor(Color("SecondaryColor"))
                                Text(NSLocalizedString("Emoji Board - Communicate using curated emojis or add images",
                                                       comment: "Emoji") + "\n")
                                    .font(Font.custom("Avenir", size: 18))
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                        }.padding()
                        Text("\(Text(NSLocalizedString("By tapping Continue, you agree to our", comment: "By tapping Continue, you agree to our"))) \(Text("Privacy Policy").underline())")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.horizontal)
                            .onTapGesture {
                                openURL(URL(string: "https://www.deafassistant.com/privacy-policy.html")!)
                            }
                        Button(
                            action: {
                                simpleSuccessHaptic()
                                self.isActive = true
                            }
                        ){
                                    Text("Continue")
                                        .fontWeight(.semibold)
                                        .font(Font.custom("Avenir", size: 18))
                                        .frame(width: 190)
                                    .padding()
                                    .foregroundColor(Color("BrandColor"))
                                    .background(Color("SecondaryColor"))

                        }.cornerRadius(8)
                        .padding(.top, 30.0)
                    }
                    .padding(.top, 30.0)
                    .padding(.bottom, 30.0)
                }
            }
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
