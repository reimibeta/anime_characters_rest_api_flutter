import 'package:animecharactersapiflutter/models/authentication_jwt.dart';
import 'package:animecharactersapiflutter/models/profile_users.dart';
import 'package:animecharactersapiflutter/provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_profiles.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class HomeDemo extends StatefulWidget {
  @override
  _HomeDemoState createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {

  var authToken = AuthenticationJWT(email: "reimi846@gmail.com", password: "iwtdstw");
  var refreshToken = "";
  //
  var profileUsers = ProfileUsers(accessToken: null,refreshToken: null);
//  var profiles;
//  @override
//  Future<void> initState() async {
//    profiles = await profileUsers.listUsers();
////    var token = authToken.accessToken();
////    debugPrint('token: $token');
//    super.initState();
//  }
//  @override
//  void setState(fn) {
//    profiles = profileUsers.listUsers();
//    debugPrint(profiles);
//    super.setState(fn);
//  }
//  @override
//  void initState() {
//    profiles = profileUsers.listUsers();
////    debugPrint(profiles);
//    super.initState();
//  }
  BlocProfile bloc;
  @override
  void initState() {
    bloc = BlocProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Demo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                var refresh = await authToken.refreshToken(refresh: refreshToken);
                if(refresh != null){
                  debugPrint('refresh refresh: ${refresh.access}');
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed:() async {
                var token = await authToken.accessToken();
                if(token != null) {
                  setState(() {
                    refreshToken = token.refresh;
                  });
                  debugPrint('access refresh: ${token.refresh}');
                }
              },
            )
          ],
        ),
        body: _futureBuilder(bloc),
      ),
    );
  }

//  Future<Widget> _list() async {
//    return await _profileLists();
//  }

//  Widget projectWidget() {
//    return FutureBuilder(
//      builder: (context, projectSnap) {
////        if (projectSnap.connectionState == ConnectionState.none &&
////            projectSnap.hasData == null) {
////          //print('project snapshot data is: ${projectSnap.data}');
////          return Container();
////        }
////        if(projectSnap.data == null){
////          return Container();
////        }
////        debugPrint(projectSnap.data.length);
//        if(projectSnap.data != null){
//          return ListView.builder(
//            itemCount: projectSnap.data.length,
//            itemBuilder: (context, index) {
////              debugPrint('email: ' + projectSnap.data[index].email.toString());
//              Profile profile = projectSnap.data[index];
////               debugPrint(projectSnap.data);
//              return new ListTile(
//                  contentPadding: const EdgeInsets.fromLTRB(
//                      10.0, 10.0, 10.0, 10.0),
//                  title: new Text(
//                    profile.name, style: TextStyle(fontSize: 20),),
//                  subtitle: new Text(
//                    profile.email, style: TextStyle(fontSize: 16),),
//                  trailing: Container(
//                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//                    child: InkWell(
//                      child: Icon(Icons
//                          .pages), // _bookmarkIcon(widget.results[position].favorite),//Icon(Icons.bookmark_border),
//                    ),
//                  ),
//                  // ignore: unnecessary_statements
//                  onTap: () async {
//                    debugPrint(profile.url);
//                  }
//              );
//            },
//          );
//        } else {
//          return Container();
//        }
//      },
//      future: profileUsers.listUsers(),
//    );
//  }

//  Widget _profileLists() {
//    if(null){
//      return ListView.builder(
//          itemCount: 5,//profiles.length,
//          itemBuilder: (BuildContext context, int index) {
//            return new ListTile(
//                contentPadding: const EdgeInsets.fromLTRB(
//                    10.0, 10.0, 10.0, 10.0),
//                title: new Text(
//                  profiles[index].name, style: TextStyle(fontSize: 20),),
//                subtitle: new Text(
//                  profiles[index].email, style: TextStyle(fontSize: 16),),
//                trailing: Container(
//                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//                  child: InkWell(
//                    child: Icon(Icons
//                        .pages), // _bookmarkIcon(widget.results[position].favorite),//Icon(Icons.bookmark_border),
//                  ),
//                ),
//                // ignore: unnecessary_statements
//                onTap: () async {
//                  debugPrint(profiles[index].url);
//                }
//            );
//          }
//      );
//    } else {
//      return Container();
//    }
////    return FutureBuilder<List<Profile>>(
////      future: profileUsers.listUsers(),
////      builder: (context, profile) {
//
////      },
////    );
////    return ListView.builder(
//////      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//////          crossAxisCount: orientation == Orientation.portrait ? 2 : 3
//////      ),
////      itemCount: profile.length ,
////      itemBuilder: (BuildContext context, int index) {
////        return new ListTile(
////            contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
////            title: new Text(profile[index].name, style: TextStyle(fontSize: 20),),
////            subtitle: new Text(profile[index].email, style: TextStyle(fontSize: 16),),
////            trailing: Container(
////              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
////              child: InkWell(
////                child: Icon(Icons.pages),// _bookmarkIcon(widget.results[position].favorite),//Icon(Icons.bookmark_border),
////              ),
////            ),
////            // ignore: unnecessary_statements
////            onTap:() async {
////              debugPrint(profile[index].url);
////            }
////        );
//
////        return GestureDetector(
////          onTap: (){
////            print(channel[index].name);
//////            Navigator.push(
//////              context,
//////              CupertinoPageRoute(
//////                builder: (BuildContext context) => new Player(title: channel[index].name,url: channel[index].url),
//////              ),
//////            );
////          },
////          child: Card(
////            child: Stack(
////              alignment: FractionalOffset.bottomCenter,
////              children: <Widget>[
////                Container(
////                  decoration: BoxDecoration(
////                    image: DecorationImage(
////                        image: CachedNetworkImageProvider(channel[index].url),
////                        fit: BoxFit.contain
////                    ),
////                  ),
////                  margin: const EdgeInsets.only(bottom: 30),
////                ),
////                Container(
////                  alignment: Alignment.center,
////                  height: 30.0,
////                  color: Colors.white,
////                  child: Text(channel[index].name,
////                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black),),
////                )
////              ],
////            ),
////          ),
////        );
////      },
////    );
//  }

  Widget _futureBuilder(BlocProfile bloc){
    return StreamBuilder(
      stream: bloc.profiles,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return OrientationBuilder(
            builder: (context,orientation){
              return FutureBuilder<List<Profile>>(
                future: snapshot.data,
                builder: (context, profiles) {
                  if (profiles.hasError) print(profiles.error);
//                    print(snapshot.data[1]);
                  if(profiles.hasData){
//                    return _gridList(channels.data, orientation);
                    return ListView.builder(
                      itemCount: profiles.data.length,
                      itemBuilder: (context, index) {

                        Profile profile = profiles.data[index];
//                        debugPrint('length: ' + profiles.data.length.toString());
//                        debugPrint('email: ' + profiles.data[index].email.toString());
                        return new ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 10.0),
                            title: new Text(
                              profile.name, style: TextStyle(fontSize: 20),),
                            subtitle: new Text(
                              profile.email, style: TextStyle(fontSize: 16),),
                            trailing: Container(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                              child: InkWell(
                                child: Icon(Icons
                                    .pages), // _bookmarkIcon(widget.results[position].favorite),//Icon(Icons.bookmark_border),
                              ),
                            ),
                            // ignore: unnecessary_statements
                            onTap: () async {
                              debugPrint(profile.url);
                            }
                        );
                      },
                    );
                  } else {
//                    return Center(child: SpinKitDoubleBounce(
//                        color: Colors.grey,
//                        size: 50.0,
//                      )
//                    );
                    return Container();
                  }
                },
              );
            },
          );
        } else {
          bloc.getProfiles();
          return Container();
        }
      },
    );
  }
}
