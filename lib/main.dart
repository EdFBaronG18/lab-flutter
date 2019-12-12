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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void createUser() async {
    final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
            email: 'eb@e.com', password: 'passwordsgsg'))
        .user;
    print('Creando usuario..');
  }

  String res = '';

  void iniciarSesion() async {
    try {
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: 'edwardbaron99@gmail.com', password: '1234567'))
          .user;
      if (user != null) {
        this.res = 'Iniciaste sesion';
      } else {
        this.res = 'Hubo un error...';
      }
    } catch (e) {
      print(e);
      this.res = 'ERROR!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Iniciar sesion',
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  labelText: 'Correo',
                  contentPadding: const EdgeInsets.all(20.0)),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  contentPadding: const EdgeInsets.all(20.0)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: iniciarSesion,
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
