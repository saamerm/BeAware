//
//  AccessoryRectangularView.swift
//  PartnerExtension
//
//  Created by Saamer Mansoor on 9/16/22.
//

import SwiftUI

struct AccessoryRectangularView: View {
    var body: some View {
        HStack{
            if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                if let name = userDefaults.string(forKey: "state")
                {
                    if name == "transcribing"
                    {
                        VStack{
                            Text("Speech")
                                .font(Font.custom("Avenir", size: 12))
                            
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("Transcribing")
                                .font(Font.custom("Avenir", size: 12))
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
                                .font(Font.custom("Avenir", size: 12))
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("On")
                                .font(Font.custom("Avenir", size: 12))
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
                                .font(Font.custom("Avenir", size: 12))
                                .fontWeight(.black)
                                .foregroundColor(Color("SecondaryColor"))
                            Text("Stopped")
                                .font(Font.custom("Avenir", size: 12))
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
                            .font(Font.custom("Avenir", size: 12))
                            .fontWeight(.black)
                            .foregroundColor(Color("SecondaryColor"))
                        Text("Stopped")
                            .font(Font.custom("Avenir", size: 12))
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
                        .font(Font.custom("Avenir", size: 12))
                    
                        .fontWeight(.black)
                        .foregroundColor(Color("SecondaryColor"))
                    Text("Stopped")
                        .font(Font.custom("Avenir", size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(Color("SecondaryColor"))
                }
                Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                    .foregroundColor(Color("SecondaryColor"))
            }
        }
    }
}

struct AccessoryRectangularView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularView()
    }
}

struct AccessoryCircleView: View {
    var body: some View {
        if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
            if let name = userDefaults.string(forKey: "state")
            {
                if name == "transcribing"
                {
                    Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                        .foregroundColor(Color("stopred"))
                }
                else if name == "noise alert"
                {
                    Text("\(Image(systemName: "stop.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                        .foregroundColor(Color("stopred"))
                }
                else
                {
                    Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                        .foregroundColor(Color("SecondaryColor"))
                }
            }
            else{
                Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                    .foregroundColor(Color("SecondaryColor"))
            }
        }
        else{
            Text("\(Image(systemName: "record.circle.fill"))")                .font(Font.custom("Avenir", size: 48))
                .foregroundColor(Color("SecondaryColor"))
        }
    }
}
