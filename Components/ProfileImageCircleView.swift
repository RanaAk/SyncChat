//
//  ProfileImageCircleView.swift
//  SyncChat
//
//  Created by RANA  on 10/8/24.
//

import SwiftUI
import UIKit

struct ProfileImageCircleView: View {
    @EnvironmentObject var profileViewModel : ProfileViewModel
    var imageUrl : String?
    var online : Bool
    var name : String = ""
    let imageCache = NSCache<NSString, UIImage>()
    
    @Environment(\.colorScheme) private var isColor
    var body: some View {
        NavigationStack {
            if imageUrl != nil {
                VStack {
                    if let imageString = imageUrl, let imageUrl = URL(string: imageString) {
                        CachedImageView(imageUrl: imageUrl, imageCache: imageCache)
                            .frame(width : 110 , height: 90)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay {
                                
                                if online {
                                    Circle()
                                        .frame(width: 15, height: 20)
                                        .foregroundStyle(.green)
                                        .position(x: 80, y: 81)
                                    
                                }
                            }
                        
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .foregroundColor(.gray)
                    }
                    
                    Text("\(name.firstNameOnly)")
                        .foregroundStyle(isColor == .light ? .black.opacity(0.8) : .white.opacity(0.8))
                    
                }
            }
            else {
                
                Circle()
                    .frame(width: 110, height: 90)
                    .foregroundStyle(.gray)
                    .overlay {
                        
                        if online {
                            Circle()
                                .frame(width: 15, height: 20)
                                .foregroundStyle(.green)
                                .position(x: 80, y: 81)
                            
                        }
                    }
            }
        }
    }
}

#Preview {
    ProfileImageCircleView(online: true)
        .environmentObject(ProfileViewModel())
}
