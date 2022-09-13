//
//  MarvelApiKey.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 08/09/2022.
//

import Foundation

class MarvelApiManager{
    static let publicKey: String = "b12e3d0f8cbd001762bb7bc73fb4055a"
    static let privateKey: String = "6a89271c9a773ad112b0739ce781048130236106"
    //TODO: generar hash dinámicamente utilizando la hora actual como dato aleatorio.
    static let hash: String = "74b3763da6291843c112ba10c134dde8"
    static let endpoint: String = "https://gateway.marvel.com/v1/public"
    static let defaultTs: String = "1"
    static let limit: Int = 15
    
    /**
     Retorna los personajes, con una paginación por defecto.
     Recibe como parámetro el offset deseado.
     */
    static func getCharactersUrl(limit: Int, offset: Int) -> String{
        let urlString = "\(MarvelApiManager.endpoint)/characters?apikey=\(MarvelApiManager.publicKey)&hash=\(MarvelApiManager.hash)&ts=\(MarvelApiManager.defaultTs)&limit=\(limit)&offset=\(offset)"
        return urlString
    }
    
    static func getEventsUrl(limit: Int, orderBy: String) -> String{
        let urlString = "\(MarvelApiManager.endpoint)/events?apikey=\(MarvelApiManager.publicKey)&hash=\(MarvelApiManager.hash)&ts=\(MarvelApiManager.defaultTs)&limit=\(limit)&orderBy=\(orderBy)"
        return urlString
    }
    
}
