import 'package:firebase_cli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _auth = AuthService();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign in to the App'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: ElevatedButton(
            child: const Text('Sign in anon'),
            onPressed: () async {
              //dynamic result = _auth.signInAnon();
              User? result = await _auth.signInAnon();
              if (result == null) {
                print('Error signing in');
              } else {
                print('Signed in: ${result.uid}');
              }
            },
          ),
        ),
      ),
    );
  }
}

class AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in as anon
  Future<User?> signInAnon() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User? anonUser = result.user;
      return anonUser;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  // sign in with email and pw
  // register with email and pw
  // sign out
}
