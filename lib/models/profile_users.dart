import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/hosts.dart';

class Profile {
  final int id;
  final String email;
  final String name;
  final String url;

  Profile({this.id,this.email,this.name,this.url});

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      url: json['url'] as String
    );
  }
//  factory Channels.fromJson(Map<String, dynamic> json) {
}

class ProfileUsers {
  final String accessToken;
  final String refreshToken;

  ProfileUsers({@required this.accessToken,@required this.refreshToken});

  Future<List<Profile>> listUsers() async {
    final response = await http.get(HOST_URL_PROFILE_USERS);
//    debugPrint(response.body);
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//    final data = Profile.fromJson(parsed);
    List<Profile> data = parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
    debugPrint('Profiles: ${data.length}');
    return data;
  }
}