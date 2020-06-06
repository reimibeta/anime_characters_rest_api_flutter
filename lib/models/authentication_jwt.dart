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
    if(!json.containsKey('access')) {
      return Token(
//          access: json['access'] as String,
          refresh: json['refresh'][0] as String
      );
    } else {
      return Token(
          access: json['access'] as String,
          refresh: json['refresh'] as String
      );
    }
  }
}

class AuthenticationJWT {

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
//    debugPrint('responce: ${response.body}');
    final parsed = json.decode(response.body);
    var token = Token.fromJson(parsed);
//    debugPrint('Token: ${token.refresh}');
//    var token = Token.fromJsonRefreshToken(parsed);
    return token;
  }
}