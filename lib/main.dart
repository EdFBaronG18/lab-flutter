import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginFirebase',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Login con Firebase'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';

  final formKey2 = GlobalKey<FormState>();
  String email2 = '';
  String pass2 = '';
  String nombre = '';
  String apellido = '';

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseApp app;
  DatabaseReference usuariosRef;

  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;

  void iniciarApp() async {
    app = await FirebaseApp.configure(
      name: 'db2',
      options: Platform.isIOS
          ? const FirebaseOptions(
              googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
              gcmSenderID: '297855924061',
              databaseURL: 'https://laboratorio-d016b.firebaseio.com/',
            )
          : const FirebaseOptions(
              googleAppID: '1:334557453340:android:39cdb709342de6765913d9',
              apiKey: 'AIzaSyC3MUQrvyb-sKrK4Br2PTkct-4aCgyKD80',
              databaseURL: 'https://laboratorio-d016b.firebaseio.com/',
            ),
    );
    final FirebaseDatabase db = FirebaseDatabase(app: app);
    usuariosRef = db.reference().child('usuarios');
    db.setPersistenceEnabled(true);
  }

  @override
  void initState() {
    iniciarApp();
  }

  void createUser() async {
    try {
      formKey2.currentState.save();
      final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: this.email2, password: this.pass2))
          .user;
      print('Creando usuario..');
      usuariosRef.push().set(<String, String>{
        'nombre': this.nombre,
        'apellido': this.apellido,
        'email': this.email2
      });
    } catch (e) {
      print(e);
      print('ERROR!');
    }
  }

  String res = '';

  void iniciarSesion() async {
    try {
      formKey.currentState.save();
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: this.email, password: this.pass))
          .user;
      if (user != null) {
        print('Iniciaste sesion');
      } else {
        print('Hubo un error...');
      }
    } catch (e) {
      print(e);
      print('ERROR!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Form(
                key: this.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Iniciar sesion',
                    ),
                    TextFormField(
                      obscureText: false,
                      onSaved: (value) => this.email = value,
                      decoration: InputDecoration(
                          labelText: 'Correo',
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                    TextFormField(
                      obscureText: true,
                      onSaved: (value) => this.pass = value,
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                    RaisedButton(
                      onPressed: iniciarSesion,
                      child: Text('Iniciar Sesion',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
              Form(
                key: this.formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Registro',
                    ),
                    TextFormField(
                      obscureText: false,
                      onSaved: (value) => this.email2 = value,
                      decoration: InputDecoration(
                          labelText: 'Correo',
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                    TextFormField(
                      obscureText: true,
                      onSaved: (value) => this.pass2 = value,
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                    TextFormField(
                      obscureText: false,
                      onSaved: (value) => this.nombre = value,
                      decoration: InputDecoration(
                          labelText: 'Nombre',
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                    TextFormField(
                      obscureText: false,
                      onSaved: (value) => this.apellido = value,
                      decoration: InputDecoration(
                          labelText: 'Apellido',
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                    RaisedButton(
                      onPressed: createUser,
                      child:
                          Text('Registrarse', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
