//
//  VeriYapilari.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import Foundation

//Api Bilgileri---------------------
var base_url = "http://192.168.1.37:8888/cometoyourselfapi/api"


//Kullanıcı Bilgileri---------------
var kullanici_adi = String()
var kullanici_mail = String()
var kullanici_sifre = String()
var kullanici_puan = Int()
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
