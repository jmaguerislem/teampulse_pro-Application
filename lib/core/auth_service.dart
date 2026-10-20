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

/// Gère les comptes EN MÉMOIRE (temporaire).
/// Plus tard, chaque méthode appellera l'API + PostgreSQL
/// (le mot de passe sera haché côté serveur, jamais stocké en clair).
class AuthService {
  static final List<Account> _accounts = [];

  static String _norm(String email) => email.trim().toLowerCase();

  static bool isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());
  }

  /// Retourne null si OK, sinon un message d'erreur.
  static String? register({
    required String fullName,
    required String email,
    required String password,
  }) {
    final e = _norm(email);
    if (_accounts.any((a) => a.email == e)) {
      return 'Un compte existe déjà avec cet e-mail.';
    }
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

  /// Met à jour nom et e-mail. Retourne null si OK, sinon un message d'erreur.
  static String? updateProfile({
    required String currentEmail,
    required String newName,
    required String newEmail,
  }) {
    final acc = _byEmail(currentEmail);
    if (acc == null) return 'Compte introuvable.';
    final e = _norm(newEmail);
    if (e != acc.email && _accounts.any((a) => a.email == e)) {
      return 'Cet e-mail est déjà utilisé.';
    }
    acc.fullName = newName.trim();
    acc.email = e;
    return null;
  }

  /// Retourne null si OK, sinon un message d'erreur.
  static String? changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) {
    final acc = _byEmail(email);
    if (acc == null) return 'Compte introuvable.';
    if (acc.password != oldPassword) {
      return 'L\'ancien mot de passe est incorrect.';
    }
    acc.password = newPassword;
    return null;
  }
}
