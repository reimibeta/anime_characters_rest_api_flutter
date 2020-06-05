import 'dart:async';
import 'dart:convert';
import 'package:animecharactersapiflutter/models/profile_users.dart';
import 'package:animecharactersapiflutter/utils/hosts.dart';
import 'package:flutter/cupertino.dart';

import '../provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
//import '../utils/connectivity/check_connection.dart';

// class Bloc extends Object with Validators
class BlocProfile extends BlocBase {
  final _profiles = new BehaviorSubject<Future<List<Profile>>>();
  // Add data to stream
  Stream<Future<List<Profile>>> get profiles => _profiles.stream;
  // Change data
  Function(Future<List<Profile>>) get sinkProfiles => _profiles.sink.add;

  getProfiles() {
    sinkProfiles(fetchProfiles(http.Client()));
  }

  Future<List<Profile>> fetchProfiles(http.Client client) async {
    final response = await client.get(HOST_URL_PROFILE_USERS);
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    final channels = parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
    debugPrint(channels[1].email);
    return channels;
  }
//  // connection
//  final _connection = new BehaviorSubject<bool>();
//  Stream<bool> get connection => _connection.stream;
//  Function(bool) get sinkConnection => _connection.sink.add;
//  checkConnection(){
//    CheckConnection.check(
//      onConnected: () => sinkConnection(true),
//      onDisconnected: () => sinkConnection(false)
//    );
//  }

  // Clean up or Close Stream
  dispose(){
    _profiles.close();
//    _connection.close();
  }
}
