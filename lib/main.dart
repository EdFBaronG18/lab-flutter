import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';

  final formKey2 = GlobalKey<FormState>();
  String email2 = '';
  String pass2 = '';

  void createUser() async {
    try {
      formKey2.currentState.save();
      final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: this.email2, password: this.pass2))
          .user;
      print('Creando usuario..');
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
