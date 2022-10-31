//
//  MediumWidgetView.swift
//  PartnerExtension
//
//  Created by Saamer Mansoor on 9/16/22.
//

import SwiftUI

struct MediumWidgetView: View {
    var body: some View {
        ZStack{
            Color("BrandColor")
                .ignoresSafeArea()
            HStack{
                ZStack{
                    Color("BrandColor")
                    Image("Splash")
                        .resizable()
                        .scaledToFit()
                        .padding([.vertical])
                        .clipped()
                }
                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                    if let name = userDefaults.string(forKey: "state")
                    {
                        if name == "transcribing"
                        {
                            VStack{
                                Text("Speech")
                                    .font(Font.custom("Avenir", size: 16))
                                
                                    .fontWeight(.black)
                                    .foregroundColor(Color("SecondaryColor"))
                                Text("Transcribing")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                                .foregroundColor(Color("stopred"))
                        }
                        else if name == "noise alert"
                        {
                            VStack{
                                Text("Noise Alert")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.black)
                                    .foregroundColor(Color("SecondaryColor"))
                                Text("On")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                                .foregroundColor(Color("stopred"))
                        }
                        else
                        {
                            VStack{
                                Text("Noise Alert")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.black)
                                    .foregroundColor(Color("SecondaryColor"))
                                Text("Stopped")
                                    .font(Font.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                                .foregroundColor(Color("SecondaryColor"))
                        }
                    }
                    else{
                        VStack{
                            Text("Noise Alert")
                                .font(Font.custom("Avenir", size: 16))
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("Stopped")
                                .font(Font.custom("Avenir", size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                            .foregroundColor(Color("SecondaryColor"))
                    }
                }
                else{
                    VStack{
                        Text("Noise Alert")
                            .font(Font.custom("Avenir", size: 16))
                        
                            .fontWeight(.black)
                            .foregroundColor(Color("SecondaryColor"))
                        Text("Stopped")
                            .font(Font.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                        .foregroundColor(Color("SecondaryColor"))
                }
            }
        }        
    }
}

struct MediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetView()
    }
}

struct SmallWidgetView: View {
    var body: some View {
        VStack{
            if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                if let name = userDefaults.string(forKey: "state")
                {
                    if name == "transcribing"
                    {
                        VStack{
                            Text("Speech")
                                .font(Font.custom("Avenir", size: 14))
                            
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("Transcribing")
                                .font(Font.custom("Avenir", size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                            .foregroundColor(Color("stopred"))
                    }
                    else if name == "noise alert"
                    {
                        VStack{
                            Text("Noise Alert")
                                .font(Font.custom("Avenir", size: 14))
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("On")
                                .font(Font.custom("Avenir", size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                            .foregroundColor(Color("stopred"))
                    }
                    else
                    {
                        VStack{
                            Text("Noise Alert")
                                .font(Font.custom("Avenir", size: 14))
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("Stopped")
                                .font(Font.custom("Avenir", size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                            .foregroundColor(Color("SecondaryColor"))
                    }
                }
                else{
                    VStack{
                        Text("Noise Alert")
                            .font(Font.custom("Avenir", size: 14))
                            .fontWeight(.black)
                            .foregroundColor(Color("SecondaryColor"))
                        Text("Stopped")
                            .font(Font.custom("Avenir", size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                        .foregroundColor(Color("SecondaryColor"))
                }
            }
            else{
                VStack{
                    Text("Noise Alert")
                        .font(Font.custom("Avenir", size: 14))
                    
                        .fontWeight(.black)
                        .foregroundColor(Color("SecondaryColor"))
                    Text("Stopped")
                        .font(Font.custom("Avenir", size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color("SecondaryColor"))
                }
                Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                    .foregroundColor(Color("SecondaryColor"))
            }
        }
    }
}
