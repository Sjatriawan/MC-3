//
//  ModalSheetDescription.swift
//  Enviroamer
//
//  Created by tiyas aria on 21/07/23.
//

import SwiftUI
import AVFoundation


struct ModalSheetDescription: View {
    var destinasi : Tourism
    
    @State private var isSpeaking = false
    @State private var speechSynthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        let description = destinasi.deskripsi
        VStack(alignment: .leading,spacing: 32){
            VStack (alignment: .leading, spacing: 12){
                Text("About \(destinasi.nama)")
                    .font(.system(size: 20, weight: .bold, design: .rounded))                 .foregroundColor(Color("black800"))
                
                HStack {
                    Button(action: {
                        if isSpeaking {
                            stopSpeaking()
                        } else {
                            speakDescription()
                        }
                    }, label: {
                        HStack{
                            Image(systemName: isSpeaking ? "stop.circle.fill" : "speaker.wave.3.fill")
                            Text(isSpeaking ? "Stop Listening" : "Listen")
                        }
                        .foregroundColor(Color("green600"))
                        
                        .cornerRadius(12)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("green600"), lineWidth: 1)
                        )
                    })
                    Spacer()
                }
            }
            
            Text(description[0])
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .regular, design: .rounded))
            
            Text(description[1])
                .foregroundColor(Color("black800"))
                .font(.system(size: 16, weight: .regular, design: .rounded))
        }
        .padding(.top, 70)
        .padding(.bottom, 20)
        .padding(.horizontal, 24)
    }
    
    private func speakDescription() {
        let utterance = AVSpeechUtterance(string: getDescriptionText())
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // You can change the language if needed
        speechSynthesizer.stopSpeaking(at: .immediate)
        speechSynthesizer.speak(utterance)
        isSpeaking = true
    }
    
    private func getDescriptionText() -> String {
        let descriptionText = "About \(destinasi.nama). \(destinasi.deskripsi[0]). \(destinasi.deskripsi[1])"
        return descriptionText
    }
    
    private func stopSpeaking() {
        if isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
        }
    }
}

struct ModalSheetDescription_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetDescription(destinasi:TourismViewModel().tourisms[0].listWisata[0] )
        
    }
}
