import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Iniciar Sesión con Correo
Future<void> loginEmail(String user, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw Exception('Usuario No Encontrado');
    } else if (e.code == 'wrong for that email') {
      throw Exception('Contraseña incorrecta');
    }
  } catch (e) {
    throw Exception('Error al iniciar sesión');
  }
}

//Cerrar Sesión
Future<void> logoutSession() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    throw Exception('Error al Cerrar Sesión');
  }
}

//Iniciar Sesión con Google para moviles
Future<UserCredential> signInWithGoogleMov() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

// Regitrarse con Google en web
Future<UserCredential> signInWithGoogleWeb() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

// recuperar contraseña con correo
Future<void> restauredPassword(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  await FirebaseAuth.instance.setLanguageCode("es-MX");
}

//Registrarse con numero de Telefono
Future<void> loginNumberPhone(String number) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
    ConfirmationResult confirmationResult =
        await auth.signInWithPhoneNumber(number);
    UserCredential userCredential = await confirmationResult.confirm('123456');
  } on FirebaseAuthException catch (e) {
    print('Error en $e');
  }
}
