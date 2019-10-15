//
//  Filmes.swift
//  BRQiOSChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 14/10/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
//

import Foundation

class Filmes {
    
    let titulo: String
    let ano: String
    let tipo: String
    let id: String
    let poster: String
    
    
    init(titulo: String, ano: String, tipo: String, id: String, poster: String) {
        self.titulo = titulo
        self.ano = ano
        self.tipo = tipo
        self.id = id
        self.poster = poster
    }
    
}
