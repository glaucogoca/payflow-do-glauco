import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payflow/app_widget.dart';

void main() {
  runApp(const AppFireBase());
}

class AppFireBase extends StatefulWidget {
  const AppFireBase({Key? key}) : super(key: key);

  @override
  State<AppFireBase> createState() => _AppFireBaseState();
}

class _AppFireBaseState extends State<AppFireBase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Material(
              child: Center(
                child: Text(
                  "Não foi possível inicializar o Firebase",
                  textDirection: TextDirection.ltr,
                ),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return AppWidget();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
