//
//  File 2.swift
//  
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SwiftUI

struct ProfileView: View{
    var body : some View {
        VStack{
            HStack{
                Image("ZirafProfile").resizable().frame(width: 128, height: 128,alignment: .leading)
                Spacer()
            }.padding(50)
            HStack{
                Text("Hi there! My name is Ahmad Fariz, and I am a metallurgical engineering student with a passion for iOS software engineering. I am currently in the Apple Developer Academy Program, where I hope to expand my knowledge and skills in this exciting field.\n As a metallurgical engineering student, I have developed a strong understanding of the properties and behavior of metals and their alloys, as well as the processes used to transform them into useful materials. This knowledge has given me a unique perspective on the challenges of designing and building durable and reliable hardware, which I believe will be valuable in my pursuit of software engineering. \n In my free time, I enjoy exploring new technologies and experimenting with programming languages and frameworks. I am particularly interested in Swift, Apple's programming language for iOS, macOS, and watchOS, and have already completed several online courses and personal projects using this language. \n My ultimate goal is to become a skilled software engineer and contribute to the development of innovative, user-friendly applications that enhance people's lives. I am excited to see where this journey takes me and look forward to learning and growing as a developer.").padding(10).background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                            )
                Spacer()
            }.padding(50)
        }
    }
}
