//
//  PageControl.swift
//  Infinite Carousel
//
//  Created by 김선철 on 9/26/24.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    // Page Properties
    var totalPages: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        control.allowsContinuousInteraction = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPage
    }
}

import Foundation
