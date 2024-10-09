//
//  ContentView.swift
//  StarWarsSpecies
//
//  Created by GuitarLearnerJas on 8/10/2024.
//

import SwiftUI
import AVFAudio
struct SpeciesListView: View {
    @StateObject var speciesVM = SpeciesVM()
    @State private var audioPlayer: AVAudioPlayer!
    @State private var lastSound = ""
    
    let soundNameLibrary: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    var body: some View {
        NavigationStack{
            ZStack{
                List(speciesVM.speciesArray) { species in
                    LazyVStack{
                        NavigationLink("\(species.name)", destination: DetailView(species: species))
                    }
                    .task{
                        //check to see if reaching the last item of the current page
                        await speciesVM.loadNextIfNeeded(species: species)
                    }
                }
                .font(.title)
                .listStyle(.plain)
                .navigationTitle("Species")
                if speciesVM.isLoading {
                    ProgressView()
                        .scaleEffect(8)
                        .tint(.green)
                }
            }
            .toolbar{
                ToolbarItem(placement: .status) {
                    Text("\(speciesVM.speciesArray.count) Species Loaded")
                }
                ToolbarItem(placement: .bottomBar){
                    Button("Load All") {
                        Task{
                            await speciesVM.loadAll()
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar){
                    Button {
                        let playedSound: String = soundNameLibrary[Int.random(in: 0..<soundNameLibrary.count)]
                        
                        while playedSound != lastSound {
                            playSound(soundName: playedSound)
                            print("The sound is \(playedSound)")
                            lastSound = playedSound
                        }
                    } label: {
                        Image("peek")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 25)
                    }
                    
                    
                }
            }
            .task {
                await speciesVM.getData()
            }
            .toolbar{
                Text("sdad")
            }
        }
    }
        func playSound(soundName: String){
            guard let soundFile = NSDataAsset(name: soundName) else {
                print("ERROR: Couldn't read sound file")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer?.play()
            } catch {
                print("ERROR: Couldn't play sound file: \(error.localizedDescription)")
                return
            }
        }
    
}
#Preview {
    SpeciesListView()
}
