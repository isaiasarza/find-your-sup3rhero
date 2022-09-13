//
//  AuthErrors.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 13/09/2022.
//

enum SignInErrorsEnum: String {
    case invalidEmail = "Email inválido"
    case wrongPassword = "Contraseña incorrecta"
    case defaultError = "Se ha producido un error desconocido y no es posible autenticarlo, reintente más tarde"
}

enum SignUpErrorsEnum: String{
    case invalidEmail = "Email inválido"
    case emailAlreadyInUse = "Este email ya fue utilizado"
    case defaultError = "Se ha producido un error desconocido y no es posible crear su cuenta, reintente más tarde"
}
