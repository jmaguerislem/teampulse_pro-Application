class Account {
  String fullName;
  String email;
  String password;

  Account({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

enum AuthError { accountExists, accountNotFound, emailInUse, wrongOldPassword }

/// Comptes EN MÉMOIRE (temporaire). Plus tard : API + PostgreSQL.
class AuthService {
  static final List<Account> _accounts = [];

  static String _norm(String email) => email.trim().toLowerCase();

  static bool isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());
  }

  static AuthError? register({
    required String fullName,
    required String email,
    required String password,
  }) {
    final e = _norm(email);
    if (_accounts.any((a) => a.email == e)) return AuthError.accountExists;
    _accounts.add(
      Account(fullName: fullName.trim(), email: e, password: password),
    );
    return null;
  }

  static Account? login(String email, String password) {
    final e = _norm(email);
    for (final a in _accounts) {
      if (a.email == e && a.password == password) return a;
    }
    return null;
  }

  static Account? _byEmail(String email) {
    final e = _norm(email);
    for (final a in _accounts) {
      if (a.email == e) return a;
    }
    return null;
  }

  static AuthError? updateProfile({
    required String currentEmail,
    required String newName,
    required String newEmail,
  }) {
    final acc = _byEmail(currentEmail);
    if (acc == null) return AuthError.accountNotFound;
    final e = _norm(newEmail);
    if (e != acc.email && _accounts.any((a) => a.email == e)) {
      return AuthError.emailInUse;
    }
    acc.fullName = newName.trim();
    acc.email = e;
    return null;
  }

  static AuthError? changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) {
    final acc = _byEmail(email);
    if (acc == null) return AuthError.accountNotFound;
    if (acc.password != oldPassword) return AuthError.wrongOldPassword;
    acc.password = newPassword;
    return null;
  }
}
