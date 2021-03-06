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
    
    @Published var results = [Results]()
    
    init() {
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/podcasts/top-podcasts/all/100/explicit.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let podcastData = try JSONDecoder().decode(RSS.self, from: data)
                DispatchQueue.main.async {
                    print(podcastData)
                    print("results count \(podcastData.feed.results.count)")
                    self.results = podcastData.feed.results
                    print(self.results)
                }
            }catch{
                print("failed podcast urlsession \(error)")
            }
        }.resume()
    }
}


struct URLImage: View {
    let urlString: String
    
    @State var urlData: Data?
    
    var body: some View {
        if let data = urlData, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
        } else {
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .cornerRadius(5)
                .onAppear {
                    getData()
                }
        }
    }
    
    private func getData() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.urlData = data
        }
        task.resume()
    }
}

//struct FlagImage: View {
//
//    let alpha2Code: String
//
//    @State var flagURLData: Data?
//
//    var body: some View{
//
//    }
//
//    private func getData() {
//        guard let flagURL = "https://www.countryflags.io/\()/flat/64.png`"
//        let task = URLSession.shared.dataTask(with: flagURL) {data, _, _ in
//            self.flagURLData = data
//        }
//        .resume()
//    }
//
//}


struct FlagModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
