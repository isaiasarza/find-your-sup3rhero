//
//  EventsDTO.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 12/09/2022.
//

import Foundation

struct EventsDataWrapper: Decodable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: EventsDataContainer?
    var etag: String?
}

struct EventsDataContainer: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Event]?
}

struct Event: Decodable{
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var urls: [ApiURL]?
    var modified: String?
    var start: String?
    var end: String?
    var thumbnail: Image?
    var comics: ComicList?
    var stories: StoryList?
    var series: SeriesList?
    var characters: CharacterList?
    var creators: CreatorList?
    var next: Summary?
    var previous: Summary?
}
