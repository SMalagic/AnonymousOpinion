//
//  VeriYapilari.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import Foundation

//Api Bilgileri---------------------
//var base_url = "https://ill-natured-violati.000webhostapp.com/api"
var base_url = "http://192.168.1.33:8888/cometoyourselfapi/api"

//Kullanıcı Bilgileri---------------
var kullanici_id =     String()
var kullanici_adi =    String()
var kullanici_mail =   String()
var kullanici_sifre =  String()
var kullanici_puan =   Int()
var kullanici_created_at = String()

//MODELİMİZ
struct Kullanici: Decodable{
    let id:         String
    let adsoyad:    String
    let mail:       String
    let puan:       String
}
var kullanicilarJson = [Kullanici]()

var secilen_kullanici_id = String()


//MODELİMİZ
struct Soru: Decodable{
    let id:                 String
    let soru:               String
    let oylayan_sayisi:     Int
    let created_at:         String
}
var sorularJson = [Soru]()


var soruPuanlari = [0,0,0,0,0,0]
