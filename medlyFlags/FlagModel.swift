//
//  FlagModel.swift
//  medlyFlags
//
//  Created by elliott on 9/16/21.
//

import Foundation
import SwiftUI

struct RSS: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Results]
}

struct Results: Decodable, Hashable {
    
    let artistName, name, artworkUrl100: String
    let url: URL

}

class PodcastModel : ObservableObject {
    
    @Published var items = 0..<10
    
    @Published var results = [Results]()
    
    init() {
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/podcasts/top-podcasts/all/50/explicit.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let podcastData = try JSONDecoder().decode(RSS.self, from: data)
                DispatchQueue.main.async {
                    print(podcastData)
                    self.results = podcastData.feed.results
                }
            }catch{
                print("failed podcast urlsession \(error)")
            }
        }.resume()
    }
    
}

struct FlagModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}