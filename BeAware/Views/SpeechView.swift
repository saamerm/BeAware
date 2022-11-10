//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import AVFoundation
import SwiftUI
import Speech
import WidgetKit
import StoreKit
import AppCenterAnalytics

struct SpeechView : View {
    
    @AppStorage("RatingTapCounter") var ratingTapCounter = 0
    @AppStorage("SpeechTextFontSize") var fontSize = 16.0
    @State private var isRecording = false
    @State private var rotation = 0.0
    @State private var permissionStatus = SFSpeechRecognizerAuthorizationStatus.notDetermined
    @State private var errorMessage = "For this functionality to work, you need to provide permission in your settings"
    @State private var showRateSheet = false
    @State private var transcription = ""
    @State private var task: SFSpeechRecognitionTask? = SFSpeechRecognitionTask()
    @State private var audioEngine = AVAudioEngine()
    @State private var request = SFSpeechAudioBufferRecognitionRequest()
    private var LocaleErrorMessage:String = "This functionality for speech recognition is not available in your language"
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body : some View {
        NavigationView{
            
            ZStack {
                Color("BrandColor")
                VStack{
                    if transcription == "" {
                        VStack{
                            Text("I can’t hear you clearly.  I use this tool to understand what people are saying. Please speak into the mic")
                                .font(Font.custom("Avenir", size: 24))
                                .padding(.top, 20)
                                .padding([.leading, .trailing], 30.0)
                                .foregroundColor(Color("SecondaryColor"))
                                .frame(maxHeight: .infinity)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Button(action: {
                        Task
                        {
                            Analytics.trackEvent("SelectAction: Transcription")

                            isRecording.toggle()
                            ratingTapCounter+=1
                            if ratingTapCounter == 10 || ratingTapCounter == 50 || ratingTapCounter == 150 || ratingTapCounter == 350 || ratingTapCounter == 600 || ratingTapCounter == 900
                            {
                                self.showRateSheet.toggle()
                            }
//                            print(ratingTapCounter)
                            if isRecording{
                                simpleEndHaptic()
                                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                    userDefaults.setValue("transcribing", forKey: "state")
                                }
                                WidgetCenter.shared.reloadAllTimelines()
                                startSpeechRecognization()
                            }
                            else{
                                simpleBigHaptic()
                                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                    userDefaults.setValue("stopped", forKey: "state")
                                }
                                WidgetCenter.shared.reloadAllTimelines()
                                cancelSpeechRecognization()
                            }
                        }})
                    {
                        if !isRecording{
                            ZStack{
                                Image(systemName: "mic.circle").resizable().scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("SecondaryColor"))
                                    .accessibilityHidden(true)
                                
                                Image(systemName: "record.circle.fill").resizable().scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("SecondaryColor"))
                                    .accessibilityLabel("Start Transcribing")
                                
                            }.shadow(color: .black, radius: 5, x: 0, y: 4)
                            
                        }
                        else
                        {
                            Image(systemName: "stop.circle.fill").resizable().scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color(hex: 0xea333c))
                                .shadow(color: .black, radius: 5, x: 0, y: 4)
                                .accessibilityLabel("Stop Transcribing")
                        }
                    }
                    if (permissionStatus != SFSpeechRecognizerAuthorizationStatus.authorized)
                    {
                        Text(errorMessage)
                            .font(Font.custom("Avenir", size: 16))
                            .padding()
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    TextEditor(
                        text: $transcription
                    ).accessibilityHint("This field populates in real time when the voice is being recorded")
                        .font(.custom("Avenir", size: fontSize))
                        .cornerRadius(10)
                        .border(Color("SecondaryColor"), width: 1)
                        .padding(.init(top: 12, leading: 25, bottom: 10, trailing: 25))
                        .rotationEffect(.degrees(rotation))
                    if transcription != "" {
                        HStack{
                            Button(action:{
                                transcription = ""
                            }){
                                Image(systemName: "clear")
                                    .resizable()
                                    .foregroundColor(Color("SecondaryColor"))
                                    .scaledToFit()
                                    .frame(width: 24, height: 40)
                                    .accessibilityLabel("Clear Text")
                                    .accessibilityHint("Clears the text from the window above")
                            }
                            Button(
                                action: {
                                    if rotation == 0{
                                        rotation = 180
                                    }
                                    else {
                                        rotation = 0
                                    }
                                    Analytics.trackEvent("SelectAction: TranscriptionRotate")
                                    ratingTapCounter+=1
                                    if ratingTapCounter == 10 || ratingTapCounter == 50 || ratingTapCounter == 150 || ratingTapCounter == 350 || ratingTapCounter == 600 || ratingTapCounter == 900
                                    {
                                        self.showRateSheet.toggle()
                                    }
                                }
                            ){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10).frame(width: 150, height: 40).foregroundColor(Color("SecondaryColor")).shadow(color: .black, radius: 5, x: 0, y: 4)
                                    Text("FLIP TEXT").foregroundColor(Color("BrandColor"))
                                        .font(.custom("Avenir", size: 17))
                                        .accessibilityLabel("Flip the text box")
                                        .accessibilityHint("This button flips the window for the other person to see what you typed without having to turn your hand")
                                }
                            }
                            .padding(.leading)
                            Slider(value: $fontSize, in: 16...50, step: 4)
                            {
                                Text("Font Size")
                            } minimumValueLabel: {
                                Text("A")
                                    .font(Font.custom("Avenir", size: 12))
                                    .foregroundColor(Color("SecondaryColor"))

                            } maximumValueLabel: {
                                Text("A")
                                    .font(Font.custom("Avenir", size: 20))
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            .padding(.leading)
                        }.padding()
                    }
                }
            }
            .navigationTitle("SPEECH").navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleTextColor(Color("SecondaryColor"))
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
        }// clsoing bracket for navigation view
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        .onAppear{
            requestPermission()
            Analytics.trackEvent("PageView: Speech")
        }
        // Added this to fix iPad navigation issue
        .navigationViewStyle(StackNavigationViewStyle())
    }
    //closing bracket for vard body some view
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("Available")
        } else {
            print("Available")
        }
    }
    
    func requestPermission()  {
        SFSpeechRecognizer.requestAuthorization { (authState) in
            OperationQueue.main.addOperation {
                if authState == .authorized {
                    permissionStatus = .authorized
                } else if authState == .denied {
                    permissionStatus = .denied
                } else if authState == .notDetermined {
                    permissionStatus = .notDetermined
                } else if authState == .restricted {
                    permissionStatus = .restricted
                }
            }
        }
    }
    
    func startSpeechRecognization(){
        transcription = ""
        audioEngine.isAutoShutdownEnabled = false
        let node = audioEngine.inputNode
        node.isVoiceProcessingAGCEnabled = true
        print(node.isVoiceProcessingEnabled)
        let recordingFormat = node.outputFormat(forBus: 0)
        request = SFSpeechAudioBufferRecognitionRequest()
            
        if errorMessage == LocaleErrorMessage{
            permissionStatus = .notDetermined
            isRecording = false
            return
        }

        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            errorMessage = "Error comes here for starting the audio listner =\(error.localizedDescription)"
        }
        
        guard let myRecognition = SFSpeechRecognizer() else {
            errorMessage = LocaleErrorMessage
            permissionStatus = .notDetermined
            isRecording = false
            return
        }
        
        print(myRecognition.isAvailable)
        if !myRecognition.isAvailable {
            errorMessage = "Recognition is not free right now, Please try again after some time."
        }
        task = myRecognition.recognitionTask(with: request) { (response, error) in
            guard let response = response else {
                if error != nil {
                    errorMessage = error?.localizedDescription ?? "For this functionality to work, you need to provide permissions in your settings"
                }else {
                    errorMessage = "Problem in giving the response"
                }
                return
            }
            let message = response.bestTranscription.formattedString
            if message != ""{
                transcription = message
            }
        }
    }
    // Figured out thanks to https://www.wepstech.com/multi-user-voice-recognition-in-ios-swift-5/
    func cancelSpeechRecognization() {
        task?.finish()
        task?.cancel()
        task = nil
        
        request.endAudio()
        audioEngine.stop()
        
        //MARK: UPDATED
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
}

struct SpeechView_Previews : PreviewProvider {
    static var previews: some View {
        SpeechView()
    }
}

func simpleSuccessHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

func simpleEndHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

func simpleBigHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}

/*
 Supported locale identifiers are {(
     "nl-NL",
     "es-MX",
     "fr-FR",
     "zh-TW",
     "it-IT",
     "vi-VN",
     "fr-CH",
     "es-CL",
     "en-ZA",
     "ko-KR",
     "ca-ES",
     "ro-RO",
     "en-PH",
     "es-419",
     "en-CA",
     "en-SG",
     "en-IN",
     "en-NZ",
     "it-CH",
     "fr-CA",
     "hi-IN",
     "da-DK",
     "de-AT",
     "pt-BR",
     "yue-CN",
     "zh-CN",
     "sv-SE",
     "hi-IN-translit",
     "es-ES",
     "ar-SA",
     "hu-HU",
     "fr-BE",
     "en-GB",
     "ja-JP",
     "zh-HK",
     "fi-FI",
     "tr-TR",
     "nb-NO",
     "en-ID",
     "en-SA",
     "pl-PL",
     "ms-MY",
     "cs-CZ",
     "el-GR",
     "id-ID",
     "hr-HR",
     "en-AE",
     "he-IL",
     "ru-RU",
     "wuu-CN",
     "de-DE",
     "de-CH",
     "en-AU",
     "nl-BE",
     "th-TH",
     "pt-PT",
     "sk-SK",
     "en-US",
     "en-IE",
     "es-CO",
     "hi-Latn",
     "uk-UA",
     "es-US"
 )}
 */
