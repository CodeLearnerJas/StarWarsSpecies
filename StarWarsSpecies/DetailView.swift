//
//  SwiftUIView.swift
//  StarWarsSpecies
//
//  Created by GuitarLearnerJas on 9/10/2024.
//

import SwiftUI

struct DetailView: View {
    let species: Species
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(species.name)
                .font(.title)
                .fontWeight(.bold)
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
            
            Group {
                HStack{
                    Text("Classification:")
                        .bold()
                    Text(species.classification)
                }
                HStack{
                    Text("Designation:")
                        .bold()
                    Text(species.designation)
                }
                HStack{
                    HStack{
                        Text("Height:")
                            .bold()
                        Text(species.average_height)
                    }
                    Spacer()
                    HStack{
                        Text("Lifespan:")
                            .bold()
                        Text(species.average_lifespan)
                    }
                }
                HStack{
                    Text("Language:")
                        .bold()
                    Text(species.language)
                }
                HStack{
                    Text("Skin Color:")
                        .bold()
                    Text(species.skin_colors)
                }
                HStack{
                    Text("Hair Color:")
                        .bold()
                    Text(species.hair_colors)
                }
                HStack(alignment: .top){
                    Text("Eye Color:")
                        .bold()
                    Text(species.eye_colors)
                }
            }
            .font(.title2)
            HStack{
                Spacer()
                AsyncImage(url: URL(string: returnSpeciesURL())) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 200)
                            .multilineTextAlignment(.center)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                            .animation(.default, value: image)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    func returnSpeciesURL() -> String {
        var newName = species.name.replacingOccurrences(of: " ", with: "-")
        newName = newName.replacingOccurrences(of: "'", with: "")
        return "https://gallaugher.com/wp-content/uploads/2023/04/\(newName).jpg"
    }
}

#Preview {
    DetailView(species: Species(name: "Swifter", classification: "Coder", designation: "sentient", average_height: "175",average_lifespan: "83", language: "Swift", skin_colors: "various", hair_colors: "various or none", eye_colors: "blue, green, brown, black, hzel, gray, or voilet"))
}
