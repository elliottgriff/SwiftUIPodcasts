//
//  ContentView.swift
//  medlyFlags
//
//  Created by elliott on 9/16/21.
//

import SwiftUI
import Kingfisher

struct FlagListView: View {
    
    @ObservedObject var podcasts = PodcastModel()
    
    var body: some View{
        NavigationView {
            List(podcasts.results, id: \.self) { pod in
                HStack {
                    KFImage(URL(string: pod.artworkUrl100))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .cornerRadius(5)
                    
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
                
                Link(destination: pod.url, label: {
                    
                })
                .frame(width: 0.1)
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
