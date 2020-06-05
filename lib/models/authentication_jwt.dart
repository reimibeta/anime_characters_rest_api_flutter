import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/hosts.dart';

class Token {
  final String access;
  final String refresh;

  Token({this.access,this.refresh});

  factory Token.fromJson(Map<String, dynamic> json){
    return Token(
        access: json['access'] as String,
        refresh: json['refresh'] as String
    );
  }
}

class AuthenticationJWT {
//  static final String host = Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
//  static final String accessTokenEndPoint = HOST_URL_ACCESS_TOKEN;
//  static final String refreshTokenEndPoint = HOST_URL_REFRESH_TOKEN;

//  Future<String> accessToken() async {
//    var data = http.post(tokenEndPoint,
//        body: {
//          "email": "reimi846@gmail.com",
//          "password": "iwtdstw",
//        })
//        .then((result) {
//      debugPrint(result.body.toString());
//    }).catchError((error) {
//      debugPrint(error.toString());
//    });
//    return data;
////    final response = await http.post(tokenEndPoint,
////      body: {
////        "email": "reimi846@gmail.com",
////        "password": "iwtdstw",
////      }
////    );
////    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
////    return parsed.map<Token>((json) => Token.fromJson(json)).toList();
//  }

//  Future<List<Token>> fetchChannels(http.Client client) async {
//    final response = await client.get('http://dashboard.kh846.com//api/react-native/khmertvhd-react-native-v1');
//    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//    final channels = parsed.map<Token>((json) => Token.fromJson(json)).toList();
//    return channels;
//  }
  final email;
  final password;
  AuthenticationJWT({@required this.email,@required this.password});

  Future<Token> accessToken() async {
    final response = await http.post(HOST_URL_ACCESS_TOKEN,
      body: {
        "email": this.email,
        "password": this.password,
      }
    );
    final parsed = json.decode(response.body);
    var token = Token.fromJson(parsed);
    // debugPrint('Token: ${token.access}');
    return token;
  }

  Future<Token> refreshToken({@required String refresh}) async {
    final response = await http.post(HOST_URL_REFRESH_TOKEN,
        body: {
          "refresh": refresh,
        }
    );
    final parsed = json.decode(response.body);
    var token = Token.fromJson(parsed);
    // debugPrint('Token: ${token.access}');
    return token;
  }
}