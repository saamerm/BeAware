//
//  InlineWidgetView.swift
//  PartnerExtension
//
//  Created by Saamer Mansoor on 9/16/22.
//

import SwiftUI

struct InlineWidgetView: View {
    var body: some View {
        if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
            if let name = userDefaults.string(forKey: "state")
            {
                if name == "transcribing"
                {
                    Image(systemName: "stop.circle.fill")
                    Text("Speech Transcribing")
                }
                else if name == "noise alert"
                {
                    HStack{
                        Image(systemName: "stop.circle.fill")
                        Text("Noise Alert: On")
                    }
                }
                else
                {
                    HStack{
                        Image(systemName: "record.circle.fill")
                        Text("Noise Alert: Stopped")
                    }
                }
            }
            else{
                HStack{
                    Image(systemName: "record.circle.fill")
                    Text("Noise Alert: Stopped")
                }
            }
        }
        else{
            HStack{
                Image(systemName: "record.circle.fill")
                Text("Noise Alert: Stopped")
            }
        }
    }
}

struct InlineWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        InlineWidgetView()
    }
}
