//
//  ContentView.swift
//  medlyFlags
//
//  Created by elliott on 9/16/21.
//

import SwiftUI
import WebKit

struct PodView: View {

    var results: Results
    
    var body: some View {
        VStack {
            Link(destination: results.url, label: {
                URLImage(urlString: results.artworkUrl100)
                    .frame(width: 300, height: 300)
            })
            Text(results.name)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(2)
            Text(results.artistName)
            

        }

        .navigationTitle(results.name)
    }
}

struct FlagListView: View {
    
    @ObservedObject var podcasts = PodcastModel()
    
    var body: some View{
        NavigationView {
            List(podcasts.results, id: \.self) { pod in
                HStack {
                    URLImage(urlString: pod.artworkUrl100)
                        .frame(height: 80)
//                    KFImage(URL(string: pod.artworkUrl100))
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 80)
//                        .cornerRadius(5)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(pod.name)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                    Text(pod.artistName)
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
                NavigationLink(
                    
                    destination: PodView(results: pod),
                    label: {
                    })
                
//                Link(destination: pod.url, label: {
//
//                })
//                    .frame(width: 200.0)
            }
            .navigationTitle("Top 100 Podcasts")
            
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlagListView()
    }
}
