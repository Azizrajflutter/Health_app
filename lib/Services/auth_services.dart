import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:http/http.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;
  Future<UserCredential?> SignInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {}
      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: gAuth?.idToken, accessToken: gAuth?.accessToken);
      Get.off(() => bottomnavigationbarPage());
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  void hadleGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await auth.signInWithProvider(googleAuthProvider);
      Get.off(() => bottomnavigationbarPage());
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Log out any existing Facebook user
      // await FacebookAuth.instance.logOut();

      // Sign in with Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      // Check if the login was successful
      if (result.status != LoginStatus.success) {
        // Handle if user cancels sign-in process or if there's an error
        return null;
      }

      // Get Facebook authentication credentials
      final AccessToken accessToken = result.accessToken!;

      // Create Firebase credential from Facebook authentication
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.toString());

      // Sign in to Firebase with Facebook credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the home screen or any desired screen
      Get.off(() => bottomnavigationbarPage());

      // Return the user credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle any errors
      print("Error signing in with Facebook: $e");
      return null;
    }
  }

// http Post API_______________----------------------------------------------------------------___________________-__--_-_-----____
  void login(String email, String password) async {
    try {
      var response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        print('Login Sccessfully');
      } else {
        print('Failled');
      }
    } on Exception catch (e) {
      print('$e Login Failled');
    }
  }
}
