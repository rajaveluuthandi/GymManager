//
//  GymMemberImageView.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 10/11/24.
//

import SwiftUI

struct GymMemberImageView:View {
    
    @Binding var image:UIImage?
    var baseSize:CGSize
    
    private var imageSize:CGSize {
        
        return CGSize.init(width: baseSize.width * 1.6, height: baseSize.height * 1.6)
    }
    
    var body: some View {
        
        ZStack {
            Circle()
                .frame(width:imageSize.width, height: imageSize.height, alignment: Alignment.center)
                .foregroundStyle(Color.clear)
                .overlay {
                    Circle().stroke( image != nil ? .white : Color.gray ,lineWidth:baseSize.width/10)
                }
                
            
            if let _image = image {
                Image.init(uiImage: _image)
                    .resizable()
                    .frame(width:imageSize.width,height: imageSize.height)
//                                            .scaledToFill()
                    .clipShape(Circle())
                
            } else {
                Image.init(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: baseSize.width,height: baseSize.height)
                    .foregroundStyle(Color.gray)
            }
           
           
                
        }
    }
}
