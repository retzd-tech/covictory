class Strings {
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Batal';

  // Logout
  static const String logout = 'Keluar';
  static const String logoutAreYouSure =
      'Apa anda yakin mau keluar akun ?';
  static const String logoutFailed = 'Logout gagal';

  // Sign In Page
  static const String signIn = 'Sign in';
  static const String signInWithEmailPassword =
      'Masuk dengan email dan password';
  static const String signInWithEmailLink = 'Sign in with email link';
  static const String signInWithFacebook = 'Sign in with Facebook';
  static const String signInWithGoogle = 'Masuk dengan akun Google';
  static const String goAnonymous = 'Go anonymous';
  static const String or = 'or';

  // Email & Password page
  static const String register = 'Daftar';
  static const String forgotPassword = 'Lupa kata sandi';
  static const String forgotPasswordQuestion = 'Lupa kata sandi?';
  static const String createAnAccount = 'Buat akun';
  static const String needAnAccount = 'Butuh akun? Daftar disini';
  static const String haveAnAccount = 'Sudah punya akun? Masuk disini';
  static const String signInFailed = 'Masuk gagal';
  static const String registrationFailed = 'Daftar gagal';
  static const String passwordResetFailed = 'atur ulang kata sandi gagal';
  static const String sendResetLink = 'Kirim Reset Link';
  static const String backToSignIn = 'Kembali ke masuk akun';
  static const String resetLinkSentTitle = 'Reset link terkirim';
  static const String resetLinkSentMessage =
      'Periksa email anda untuk mengatur ulang password';
  static const String emailLabel = 'Email';
  static const String emailHint = 'test@test.com';
  static const String password8CharactersLabel = 'Password (8+ karakter)';
  static const String passwordLabel = 'Password';
  static const String invalidEmailErrorText = 'Email tidak sesuai format';
  static const String invalidEmailEmpty = 'Email tidak bisa kosong';
  static const String invalidPasswordTooShort = 'Password terlalu pendek';
  static const String invalidPasswordEmpty = 'Password tidak bisa kosong';

  // Email link page
  static const String submitEmailAddressLink =
      'Submit your email address to receive an activation link.';
  static const String checkYourEmail = 'Check your email';
  static String activationLinkSent(String email) =>
      'We have sent an activation link to $email';
  static const String errorSendingEmail = 'Error sending email';
  static const String sendActivationLink = 'Send activation link';
  static const String activationLinkError = 'Email activation error';
  static const String submitEmailAgain =
      'Please submit your email address again to receive a new activation link.';
  static const String userAlreadySignedIn =
      'Received an activation link but you are already signed in.';
  static const String isNotSignInWithEmailLinkMessage =
      'Invalid activation link';

  // Home page
  static const String homePage = 'Home Page';

  // Developer menu
  static const String developerMenu = 'Developer menu';
  static const String authenticationType = 'Authentication type';
  static const String firebase = 'Firebase';
  static const String mock = 'Mock';
}
