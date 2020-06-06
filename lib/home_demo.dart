import 'package:animecharactersapiflutter/models/authentication_jwt.dart';
import 'package:animecharactersapiflutter/models/profile_users.dart';
import 'package:animecharactersapiflutter/provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_profiles.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class HomeDemo extends StatefulWidget {
  @override
  _HomeDemoState createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {

  var authToken = AuthenticationJWT(email: "reimi846@gmail.com", password: "iwtdstw");
  var refreshToken = "";
  //
  var profileUsers = ProfileUsers(accessToken: null,refreshToken: null);

  BlocProfile bloc;
  @override
  void initState() {
    bloc = BlocProfile();
    super.initState();
  }
  // facebook login
  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
//    await facebookLogin.lo
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        onLoginStatusChanged(true);
        break;
    }
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
                  debugPrint('refresh refresh: ${refresh.refresh}, access access: ${refresh.access}');
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
//        body: _futureBuilder(bloc),
        body: Container(
          child: Center(
            child: isLoggedIn
                ? Text("Logged In")
                : RaisedButton(
              child: Text("Login with Facebook"),
              onPressed: () => initiateFacebookLogin(),
            ),
          ),
        ),
      ),
    );
  }

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
