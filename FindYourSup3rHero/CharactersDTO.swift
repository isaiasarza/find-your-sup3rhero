//
//  Characters.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 08/09/2022.

// DTOs utilizados en la api de marvel
//

import Foundation

struct CharacterDataWrapper: Decodable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: CharacterDataContainer?
    var etag: String?
}

struct CharacterDataContainer: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Character]?
}

struct Character: Decodable{
    var id: Int?
    var name: String?
    var description: String?
    var modified: String? //Date
    var resourceURI: String?
    var urls: [ApiURL]?
    var thumbnail: Image?
    var comics: ComicList?
    var stories: StoryList?
    var events: EventList?
    var series: SeriesList?
}
