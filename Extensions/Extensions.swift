//
//  Extensions.swift
//  SyncChat
//
//  Created by RANA  on 1/8/24.
//

import Foundation
import SwiftUI


extension View {
    func cornerridius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape (RoundedCorner (radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath( roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path (path.cgPath)
    }
}

extension Date {
    var dateAsString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm, dd MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    var firstNameOnly: String {
        let nameFormatter = PersonNameComponentsFormatter()
        if let components = nameFormatter.personNameComponents(from: self) {
            return components.givenName ?? ""
        }
        return ""
    }
}

