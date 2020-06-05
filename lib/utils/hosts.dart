import 'dart:io' show Platform;

// host
final String HOST_URL = Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
// token access and token refresh
final String HOST_URL_ACCESS_TOKEN = HOST_URL + '/api/token/';
final String HOST_URL_REFRESH_TOKEN = HOST_URL + '/api/token/refresh/';
// profile user
final String HOST_URL_PROFILE_USERS = HOST_URL + '/userprofiles/profile/';