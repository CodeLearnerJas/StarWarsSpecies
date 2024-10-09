//
//  Species.swift
//  StarWarsSpecies
//
//  Created by GuitarLearnerJas on 8/10/2024.
//

import Foundation

struct Species:Identifiable, Codable {
    let id = UUID().uuidString
    var name: String = ""
    var classification: String = ""
    var designation: String = ""
    var average_height: String = ""
    var average_lifespan: String = ""
    var language: String = ""
    var skin_colors: String = ""
    var hair_colors: String = ""
    var eye_colors: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case classification
        case designation
        case average_height
        case average_lifespan
        case language
        case skin_colors
        case hair_colors
        case eye_colors
    }
}

