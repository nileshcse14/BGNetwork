//
//  ContentView.swift
//  Example
//
//  Created by Nilesh on 12/12/23.
//

import SwiftUI
import BGNetwork
import Combine

struct ContentView: View {
    @State  var cancellables = Set<AnyCancellable>()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            self.makeRequest()
        }
        .padding()
    }
    
    
    func makeRequest() {
        //https://jsonplaceholder.typicode.com/posts
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            return
        }
        
        let builder = BGRequestBuilder(baseURL: url, path: "/posts")
        builder.set(method: .get)
        
        let network = BGNetwork()
        network.makeRequest(with: builder, type: [WelcomeElement].self)
            .sink { completion in
                switch completion {
                case .finished:
                    print("******* finished")
                case .failure(let error):
                    print("******* error \(error)")
                }
            } receiveValue: { value in
                print("******* value \(value)")
            }
            .store(in: &cancellables)
        
        
    }
}

struct WelcomeElement: Codable {
    var userID, id: Int?
    var title, body: String?
}

#Preview {
    ContentView()
}
