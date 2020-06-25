# flutterexample
An example project to test the cidaas flutter sdk

## Getting Started
This example project shows how to use the cidaas flutter sdk.

### How to test the example
To test the example project, first clone this project onto your local machine.  
You will have to setup a [cidaas application](https://docs.cidaas.de/manage-applications.html) in your cidaas admin dashboard.  
Add the openid, profile, email & offline_access scopes to your test app.  
To authenticate via the authorization code flow, you have to edit the cidaas_config.json under assets/cidaas_config.json.  
Fill in your baseUrl, clientId, clientSecret & the redirectUri you want to use.

### Brief description:

#### main.dart:
In the main.dart, the Cidaas class is implemented. Here we return the different screens/ widgets to be used in the authentication progress.

* getLoggedInScreen({tokenEntity}) - returns the screen to be shown when the user is authenticated. The tokenEntity-Parameter can be used to obtain the TokenEntity contianing the access_token, id_token, sub & refresh token.
* getSplashScreen() - returns a custom splash screen to be used while the authentication is doing asynchronous tasks in the background
* getLoggedOutScreen({context}) - returns the screen to be shown when the user is not authenticated. Here the CidaasLoginProvider.doLogin(context) method is called to start the login process.
* getAuthenticationFailureScreen({errorMessage}) - this screen is shown when no acccess_token could be obtained

Notice that the context in which the MyCidaasImpl-class needs a registered AuthenticationBloc. This is added to the context using the BlocProvider:
```
return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc();
      },
```

The CidaasLoginProvider.isAuth() method can be used to check if the user is logged in. When called, this method checks if an access_token is already stored & not expired.

#### LoggedInScreen.dart:
The LoggedInScreen represents the part of your app which is displayed once the user has authenticated himself.  
It can receive the initial TokenEntity after Login via the constructor.  
You can also always call the CidaasLoginProvider.getStoredAccessToken() method to obtain the currently used access_token.  
Via the CidaasLoginProvider.getTokenClaimSetForToken(tokenEntity.idToken) you can get the token claim set as Map<String, dynamic>.  
The TokenEntity holds the access_token, the sub, the refresh_token (if your app has got the 'offline_access' scope) & the id_token (if your app has got the 'openid' scope).

Finally, you can trigger the logout process using CidaasLoginProvider.doLogout(context).
Once logged out, the TokenEntity stored via the flutter_secure_storage will be deleted and the user will get redirected back to the screen provided by getLoggedOutScreen().

#### user_info_entity

The user_info_entity is used as an example on how the token claims could be used to be parsed into an dart object.

### Mentions:
The cidaas flutter sdk is using the [Bloc pattern](https://pub.dev/packages/bloc).  
It is storing the retrieved tokens via the [Flutter secure storage](https://pub.dev/packages/flutter_secure_storage).  
To display the (web-) login screen the [Flutter webview plugin](https://pub.dev/packages/flutter_webview_plugin) is used.