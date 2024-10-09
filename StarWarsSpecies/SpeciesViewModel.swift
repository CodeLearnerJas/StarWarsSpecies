//
//  SpeciesViewModel.swift
//  StarWarsSpecies
//
//  Created by GuitarLearnerJas on 8/10/2024.
//

import Foundation

@MainActor
class SpeciesVM: ObservableObject {
    
    struct Returned: Codable {
        var results: [Species]  //use to hold the returned data from JSON
        var next: String?
    }
    
    @Published var speciesArray: [Species] = []
    @Published var isLoading: Bool = false
    var urlString: String = "https://swapi.dev/api/species/?format=json"
    
    func getData() async {
        print("🕸️ Accessing the url \(urlString)")
        isLoading = true
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not access the url \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do{
                let returnedData = try JSONDecoder().decode(Returned.self, from: data)
                isLoading = true
                urlString = returnedData.next ?? ""
                speciesArray += returnedData.results
            } catch {
                isLoading = false
                print("JSON ERROR: Could not convert the data into JSON.\(error.localizedDescription)")
            }
            
        } catch {
            print("ERROR: Could not get data and response from \(urlString)")
            isLoading = false
            return
        }
        isLoading = false
    }
    
    func loadNextIfNeeded(species: Species) async {
        guard let lastSpecie = speciesArray.last else { return }
        if lastSpecie.id == species.id && urlString != "" {
            await getData()
        }
    }
    func loadAll() async {
        while urlString != "" {
            await getData()
        }
    }
}
