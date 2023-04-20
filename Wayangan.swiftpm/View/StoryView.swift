//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 16/04/23.
//

import Foundation
import SwiftUI
import SpriteKit
import Combine

struct StoryView: View{

    @State private var value = 0
    @EnvironmentObject var dataDialogueAndClue : PassGameDialogueAndClueData
    var dialogueScript : String = ""
    var narateScript : String = ""
    var scene: SKScene {
        let scene = RamaSitaScene(dataDialogueAndClue : dataDialogueAndClue)
            let width = UIScreen.main.bounds.width
            let height = width * 1 / 2
            scene.size = CGSize(width: width, height: height)
            scene.scaleMode = .fill
            return scene
        }
        
        var body: some View {
            let message = dialogueRamaSita(dialogueKey: dataDialogueAndClue.dialogueKey)
            let naration = narateRamaSita(clueKey: dataDialogueAndClue.clueKey)
            VStack {
                Text(message)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                            )
                SpriteView(scene: scene)
                    .frame(width: scene.size.width, height: scene.size.height)
                    .ignoresSafeArea()
                Text(naration)
                    .padding()
            }.onAppear{
                withAnimation(.linear(duration: 5)) {
                                value = message.count
                            }
            }
        }
        
    func narateRamaSita (clueKey: Int)-> String
    {
        var narate : String = ""
        switch clueKey
        {
        case 1 :
            narate = "Rama was determined to rescue his wife and set out on a perilous journey to Ravana Kingdom with the help of his loyal friend, Hanuman. Meanwhile, in Lanka, Ravana boasted about his triumph over Rama and his kingdom."
        case 2 :
           narate = "Hanuman, with his immense strength, flew to Lanka and discovered Sita imprisoned in Ravana's palace. Rama and his army arrived at the shores of Lanka, ready to wage war against Ravana and his demon army."
        case 3 :
            narate = "The battle between Rama and Ravana was fierce, but Rama's love for Sita and his determination to bring her back home gave him the strength to overcome his enemy."
        case 4 :
            narate = "With the help of Hanuman, Rama defeated Ravana and rescued Sita. They returned to their kingdom where they lived happily ever after. The story of Rama and Sita became a beloved tale for generations to come, teaching the virtues of love, courage, and righteousness."
        default : narate = "Once upon a time in ancient Kingdom, there lived a virtuous prince named Rama and his beloved wife, Sita. They lived peacefully in the forest, surrounded by nature's beauty. But one day Rama got separated with sita"
        }
        return narate
    }
    func dialogueRamaSita (dialogueKey: Int)-> String
    {
        var dialogue : String = ""
        switch dialogueKey
        {
        case 1 : dialogue = "Rama : Sita! Where are you? I can't find you anywhere!"
        case 2 : dialogue = "Sita : Rama! Help me! Ravana has taken me away!"
        case 3 : dialogue = "Ravana : Ha ha ha! You'll never see your wife again, Rama! She's mine now!"
        case 4 : dialogue = "Hanuman : Not so fast, Ravana! I am Hanuman, messenger of Lord Rama. I will rescue Sita and bring her back to her rightful place!"
        case 5 : dialogue = "Ravana :You think you can defeat me, Hanuman? I am the powerful king of Demen!"
        case 6 : dialogue = "Hanuman :You may be powerful, but you are not as wise as Rama. He is a true leader and a virtuous soul. He will defeat you and rescue Sita!"
        case 7 : dialogue = "Rama :Sita, have no fear. I will come for you and defeat Ravana. I will not rest until you are back in my arms where you belong."
        case 8 : dialogue = "Sita I have faith in you, Rama. I know you will come for me and defeat Ravana. I will wait for you."
        case 9 : dialogue = "Thank you for believing in me and for your unwavering support. Your faith in me means the world, and I promise to do everything in my power to make sure that we will always be together. I won't let anything or anyone stand in our way."
        default : return dialogue
        }
        return dialogue
    }
    
}

struct TypeWriterText: View, Animatable {
    var string: String
    var count = 0

    var animatableData: Double {
        get { Double(count) }
        set { count = Int(max(0, newValue)) }
    }

    var body: some View {
        let stringToShow = String(string.prefix(count))
        Text(stringToShow)
    }
}

