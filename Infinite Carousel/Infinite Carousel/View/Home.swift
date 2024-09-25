//
//  Home.swift
//  Infinite Carousel
//
//  Created by 김선철 on 9/26/24.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    // Infnite Carousel Properties
    @State private var fakedPages: [Page] = []
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TabView(selection: $currentPage,content: {
                ForEach(fakedPages) { page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(page.id.uuidString)
                    // Calculating Entire Page Scroll Offset
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIdex(page)))
                            
                            // Converting Page Offset into Progress
                            let pageProgress = pageOffset / size.width
                            // Infinite Carousel Logic
                            if -pageProgress < 1.0 {
                                // Moving to the Last Page
                                // Which is Actually the First Duplicated Page
                                // Safe Check
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                // Moving to the First Page
                                // Which is Actually the Last Duplicated Page
                                // Safe Check
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                    
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        .onAppear {
            guard fakedPages.isEmpty else { return }
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(.init(color: color))
            }
            
            fakedPages.append(contentsOf: listOfPages)
            
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                
                /// Updating ID
                firstPage.id = .init()
                lastPage.id = .init()
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
        /// Creating Some Sample Tab's
    }
    
    func fakeIdex(_ of: Page) -> Int {
        return fakedPages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

#Preview {
    Home()
}
