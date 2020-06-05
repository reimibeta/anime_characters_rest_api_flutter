import 'package:animecharactersapiflutter/authentication_jwt.dart';
import 'package:flutter/material.dart';

class HomeDemo extends StatefulWidget {
  @override
  _HomeDemoState createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {

  var authToken = AuthenticationJWT(email: "reimi846@gmail.com", password: "iwtdstw");
  var refreshToken = "";
  @override
  void initState() {

//    var token = authToken.accessToken();
//    debugPrint('token: $token');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
