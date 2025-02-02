//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import SwiftUI
import UserNotifications
import AVFoundation
import WidgetKit
import StoreKit
import AppCenterAnalytics

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
var audioRecorder: AVAudioRecorder?

struct AlertView : View {
    @AppStorage("RatingTapCounter") var ratingTapCounter = 0
    @AppStorage("noiseLength") var noiseLength = 2.0
    @AppStorage("noiseThreshold") private var noiseThreshold = 20.0
    @AppStorage("isCritical") var isCritical = false
    @State private var noiseLengthCounter = 0.0
    @State private var isRecording = false
    @State private var showRateSheet = false
    var body : some View {
        NavigationView{
            ZStack {
                Color("BrandColor")
                ScrollView{
                    VStack {
                        VStack{
                            Text("Alert Frequency")
                                .font(Font.custom("Avenir", size: 24))
                                .foregroundColor(Color("SecondaryColor"))
                                .padding([.top], 20.0)
                            Slider(value: $noiseLength, in: 1...10, step: 1){
                                Text("Length") //Is never visible, but is needed
                            }minimumValueLabel:{
                                Text("1s") //Is never visible, but is needed
                            }maximumValueLabel:{
                                Text("10s") //Is never visible, but is needed
                            }
                            .padding(.horizontal)
                            Text(String(describing: Int(noiseLength)) + " " + NSLocalizedString("seconds", comment: "2 seconds"))
                                .font(Font.custom("Avenir", size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("SecondaryColor"))
                                .padding(.leading)
                            Spacer(minLength: 20)
                        }
                        VStack{
                            Text("Noise Threshold")
                                .font(Font.custom("Avenir", size: 24))
                                .foregroundColor(Color("SecondaryColor"))
                            Slider(value: $noiseThreshold, in: 0...30, step: 5){
                                Text("Amplitude") //Is never visible, but is needed
                            }minimumValueLabel:{
                                Text("\(Image(systemName:"speaker.wave.1.fill"))")
                                    .font(Font.custom("Avenir", size: 20))
                                    .foregroundColor(Color("SecondaryColor"))
                            }maximumValueLabel:{
                                Text("\(Image(systemName:"speaker.wave.3.fill"))")
                                    .font(Font.custom("Avenir", size: 20))
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            .padding(.horizontal)
                            Text(String(describing: Int(noiseThreshold) + 60) + NSLocalizedString(" db", comment: " db"))
                                .font(Font.custom("Avenir", size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("SecondaryColor"))
                                .padding(.leading)

                            Spacer(minLength: 30)
                        }
                        if !isRecording{
                            Image(systemName: "record.circle.fill")
                                .resizable().scaledToFit()
                                .shadow(color: .black, radius: 5, x: 0, y: 4)
                                .frame(width: 132, height: 132)
//                                .foregroundColor(Color(hex: 0x6bd45f))
                                .foregroundColor(Color("SecondaryColor"))
                                .accessibilityLabel("Start Noise Alert")
                                .onTapGesture {
                                    Analytics.trackEvent("SelectAction: Alert")
                                    // Functions to Start recording
                                    ratingTapCounter+=1
                                    if ratingTapCounter == 10 || ratingTapCounter == 50 || ratingTapCounter == 150 || ratingTapCounter == 350 || ratingTapCounter == 600 || ratingTapCounter == 900
                                    {
                                        self.showRateSheet.toggle()
                                    }
                                    print(ratingTapCounter)
                                    simpleBigHaptic()
                                    if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                        userDefaults.setValue("noise alert", forKey: "state")
                                    }
                                    WidgetCenter.shared.reloadAllTimelines()

                                    isRecording ? stopRecording() : startRecording(isCritical: isCritical)
                                    print(isRecording)
                                    isRecording.toggle()
                                }
                        }
                        else
                        {
                            Image(systemName: "stop.circle.fill")
                                .resizable().scaledToFit()
                                .shadow(color: .black, radius: 5, x: 0, y: 4)
                                .frame(width: 132, height: 132)
                                .foregroundColor(Color(hex: 0xea333c))
                                .accessibilityLabel("Stop Noise Alert")
                                .onTapGesture {
                                    Analytics.trackEvent("SelectAction: Alert")
                                    // Functions to stop recoding
                                    ratingTapCounter+=1
                                    if ratingTapCounter == 10 || ratingTapCounter == 50 || ratingTapCounter == 150 || ratingTapCounter == 350 || ratingTapCounter == 600 || ratingTapCounter == 900
                                    {
                                        self.showRateSheet.toggle()
                                    }
                                    print(ratingTapCounter)
                                    simpleEndHaptic()
                                    if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                        userDefaults.setValue("stopped", forKey: "state")
                                    }
                                    WidgetCenter.shared.reloadAllTimelines()

                                    isRecording ? stopRecording() : startRecording(isCritical: isCritical)
                                    print(isRecording)
                                    isRecording.toggle()
                                    toggleTorch(on: isRecording)
                                }
                        }
                        if isRecording{
                            Text("Stop Noise Alert")
                                .font(Font.custom("Avenir", size: 24))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("SecondaryColor"))
                                .padding([.bottom], 20.0)
                                .accessibilityHidden(true)
                        }
                        else{
                            Text("Start Noise Alert")
                                .font(Font.custom("Avenir", size: 24))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("SecondaryColor"))
                                .padding([.bottom], 20.0)
                                .accessibilityHidden(true)
                        }
                        Spacer()
                        HStack{
                            NavigationLink(
                                destination: CriticalAlertsView()
                            ) {
                                Text(NSLocalizedString("Mark alerts as critical", comment: "Mark alerts as critical"))
                                    .font(Font.custom("Avenir", size: 18))
                                    .foregroundColor(Color("SecondaryColor"))
                                    .padding(.leading)
                            }.layoutPriority(1000)
                            Image(systemName: "questionmark.circle")
                            Spacer()
                            Toggle("", isOn: $isCritical)
                                .padding(.trailing)
                        }
                        .padding(.bottom)
                    }
                }}
            .onAppear{
                Analytics.trackEvent("PageView: Alert")
            }
            .navigationTitle(NSLocalizedString("ALERT", comment: "Alert Navigation Page Title"))
            .navigationBarTitleTextColor(Color("SecondaryColor"))
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showRateSheet, content: {
                Alert(
                    title: Text("Do you like this app?"),
                    primaryButton: .default(Text("Yes"), action: {
                        print("Pressed")
                        if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
                    }),
                    secondaryButton: .destructive(Text("Not"))
                )
            })
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: SettingsView()
                    ) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    
                }
            }
            Text("Test")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(timer) { input in
            print("1s timer on")
            if isRecording{
                checkNoiseLevel()
            }
        }
    }
    
    func checkNoiseLevel()
    {
        if noiseLengthCounter < noiseLength{
            noiseLengthCounter = noiseLengthCounter + 1
            return
        }
        else{
            noiseLengthCounter = 0
        }
        audioRecorder?.updateMeters()
        // NOTE: seems to be the approx correction to get real decibels
        let correction: Float = 80
//        let average = (audioRecorder?.averagePower(forChannel: 0) ?? 0) + correction
        let peak = (audioRecorder?.peakPower(forChannel: 0) ?? 0) + correction
        print(peak)
        if (peak > Float(60 + noiseThreshold))
        {
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("Noise alert notification", comment: "Noise alert notification")
            content.body = NSLocalizedString("The noise is loud at ", comment: "The noise is loud at ") + String(describing: Int(peak.rounded())) + NSLocalizedString(" db", comment: " db")
            if isCritical{
                toggleTorch(on: true)
                content.sound = .defaultCritical
            }
            
            // Configure the recurring date.
            var dateComponents = DateComponents()
            
            let date = Date()
            let calendar = Calendar.current
            dateComponents.calendar = calendar
            dateComponents.hour = calendar.component(.hour, from: date)
            dateComponents.minute = calendar.component(.minute, from: date)
            dateComponents.second = calendar.component(.second, from: date) + 1
            
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents, repeats: false)
            
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content, trigger: trigger)
            
            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.add(request) { (error) in
                if error != nil {
                    // Handle any errors.
                }
            }
        }
        else{
            toggleTorch(on: false)
        }
    }
}
struct AlertView_Previews : PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}

func startRecording(isCritical: Bool)
{
    let userNotificationCenter = UNUserNotificationCenter.current()
    var authOptions : UNAuthorizationOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound, .alert)
    if isCritical{
        authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound, .criticalAlert)
    }
    userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
        if let error = error {
            print("Error: ", error)
        }
    }
    guard let url = directoryURL() else {
        print("Unable to find a init directoryURL")
        return
    }
    
    let recordSettings = [
        AVSampleRateKey : NSNumber(value: Float(44100.0) as Float),
        AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC) as Int32),
        AVNumberOfChannelsKey : NSNumber(value: 1 as Int32),
        AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue) as Int32),
    ]
    
    let audioSession = AVAudioSession.sharedInstance()
    
    do {
        try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        audioRecorder = try AVAudioRecorder(url: url, settings: recordSettings)
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
        try audioSession.setActive(true)
        audioRecorder?.isMeteringEnabled = true
    } catch let err {
        print("Unable to start recording", err)
    }
}

func stopRecording()
{
    audioRecorder?.stop()
}

func directoryURL() -> URL? {
    let fileManager = FileManager.default
    let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = urls[0] as URL
    let soundURL = documentDirectory.appendingPathComponent("sound.m4a")
    return soundURL
}


func toggleTorch(on: Bool) {
    guard let device = AVCaptureDevice.default(for: .video) else { return }

    if device.hasTorch {
        do {
//            if #available(iOS 15.0, *) {
//                AVCaptureDevice.MicrophoneMode.wideSpectrum
//                AVCaptureDevice.MicrophoneMode(rawValue: 1)
//            } else {
//                // Fallback on earlier versions
//            }
            try device.lockForConfiguration()

            if on == true {
                device.torchMode = .on
                try device.setTorchModeOn(level: 1.0)
            } else {
                device.torchMode = .off
            }

            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    } else {
        print("Torch is not available")
    }
}
