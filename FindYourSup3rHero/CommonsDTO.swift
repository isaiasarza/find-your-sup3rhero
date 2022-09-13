//
//  CommonsDTO.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 12/09/2022.
//

import Foundation

struct ApiURL: Decodable{
    var type: String?
    var url: String?
}

struct Image: Decodable{
    var path: String?
    var `extension`: String?

}

struct ComicList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [Summary]?
}

struct StoryList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [Summary]
}

struct StorySummary: Decodable {
    var resourceURI: String?
    var name: String?
    var type: String?
}

struct EventList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [Summary]?
}

struct SeriesList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [Summary]?
}

struct CharacterList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [RoleSummary]?
}

struct CreatorList: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [RoleSummary]?
}

struct Summary: Decodable {
    var resourceURI: String?
    var name: String?
}

struct RoleSummary: Decodable {
    var resourceURI: String?
    var name: String?
    var role: String?
}
