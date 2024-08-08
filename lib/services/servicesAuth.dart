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
// Definimos la función futura asincrona
Future<UserCredential> signInWithGoogleWeb() async {
  // Create a new provider
  // Aquí se crea una nueva instancia de GoogleAuthProvider. Este objeto representa el proveedor de autenticación de Google que se utilizará para el inicio de sesión.
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  // Esta línea agrega un alcance adicional al proveedor de autenticación de Google. El alcance 'https://www.googleapis.com/auth/contacts.readonly' permite acceder a los contactos del usuario de forma de solo lectura.
  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

  //Aquí se configuran parámetros personalizados para el proveedor de autenticación. En este caso, el parámetro 'login_hint' se establece con un valor de 'user@example.com', lo que puede ayudar a pre-rellenar el campo de correo electrónico en la interfaz de inicio de sesión de Google.
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  // Esta línea intenta autenticar al usuario usando un popup de inicio de sesión proporcionado por Google. El método signInWithPopup de FirebaseAuth abre una ventana emergente para que el usuario se autentique. Una vez que el usuario se ha autenticado correctamente, la función retorna un objeto UserCredential, que contiene información sobre el usuario autenticado.
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  // Or use signInWithRedirect
  //Estas líneas comentadas representan una alternativa al método signInWithPopup. En lugar de usar una ventana emergente, se podría usar signInWithRedirect, que redirige al usuario a una página de inicio de sesión de Google. Esta opción es útil si se necesita manejar la autenticación en una página completa en lugar de un popup.
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

// Registrar con Facebook
Future<UserCredential> signInWithFacebook() async {
  // Create a new provider
  FacebookAuthProvider facebookProvider = FacebookAuthProvider();

  facebookProvider.addScope('email');
  facebookProvider.setCustomParameters({
    'display': 'popup',
  });

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(facebookProvider);

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
}
