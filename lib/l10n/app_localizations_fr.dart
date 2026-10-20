// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcomeTagline =>
      'Vos projets, en rythme.\nAlertes de retard avant qu’il ne soit trop tard.';

  @override
  String get signIn => 'Se connecter';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get continueWithoutAccount => 'Continuer sans compte';

  @override
  String get navHome => 'Accueil';

  @override
  String get navProjects => 'Projets';

  @override
  String get navTasks => 'Tâches';

  @override
  String get navTeam => 'Équipe';

  @override
  String get navMore => 'Plus';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginSubtitle =>
      'Heureux de vous revoir. Connectez-vous pour retrouver vos projets.';

  @override
  String get emailLabel => 'Adresse e-mail';

  @override
  String get emailHint => 'exemple@domaine.com';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get yourPasswordHint => 'Votre mot de passe';

  @override
  String get enterEmail => 'Entrez votre e-mail.';

  @override
  String get invalidEmail => 'Format d’e-mail invalide.';

  @override
  String get enterPassword => 'Entrez votre mot de passe.';

  @override
  String get wrongCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get noAccountYet => 'Pas encore de compte ? ';

  @override
  String get signupTitle => 'Créer un compte';

  @override
  String get signupSubtitle =>
      'Rejoignez TeamPulse Pro et gérez vos projets sans friction.';

  @override
  String get fullNameLabel => 'Nom complet';

  @override
  String get fullNameHint => 'Ex : Aya Jguirim';

  @override
  String get enterFullName => 'Entrez votre nom complet.';

  @override
  String get passwordMinHint => 'Minimum 8 caractères';

  @override
  String get passwordMinError => 'Minimum 8 caractères.';

  @override
  String get signUp => 'S’inscrire';

  @override
  String get alreadyAccount => 'Déjà un compte ? ';

  @override
  String get hello => 'Bonjour';

  @override
  String helloName(String name) {
    return 'Bonjour $name';
  }

  @override
  String get yourActivity => 'Votre activité';

  @override
  String get globalProgress => 'Avancement global';

  @override
  String projectsInProgress(int count) {
    return '$count projets en cours';
  }

  @override
  String projectsDoneCount(int count) {
    return '$count terminés';
  }

  @override
  String get statProjects => 'Projets';

  @override
  String get statTasks => 'Tâches';

  @override
  String get statDone => 'Terminées';

  @override
  String lateTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tâches en retard',
      one: '1 tâche en retard',
    );
    return '$_temp0';
  }

  @override
  String get noLateTasks => 'Aucune tâche en retard';

  @override
  String get reactQuickly => 'Réagissez rapidement';

  @override
  String get allOnTime => 'Tout est dans les temps';

  @override
  String get upcomingDeadlines => 'Échéances proches';

  @override
  String get seeAll => 'Voir tout';

  @override
  String get noDeadlines => 'Aucune échéance pour le moment';

  @override
  String get urgent => 'Urgent';

  @override
  String get soon => 'Bientôt';

  @override
  String get late => 'En retard';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get tomorrow => 'Demain';

  @override
  String tasksCount(int count) {
    return '$count tâches';
  }

  @override
  String get myProjects => 'Mes projets';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterInProgress => 'En cours';

  @override
  String get filterDone => 'Terminés';

  @override
  String get filterOnHold => 'En attente';

  @override
  String get noProjectHere => 'Aucun projet ici';

  @override
  String get statusDone => 'Terminé';

  @override
  String tasksProgress(int done, int total) {
    return '$done / $total tâches';
  }

  @override
  String get createProject => 'Créer un projet';

  @override
  String get projectName => 'Nom du projet';

  @override
  String get projectNameHint => 'Ex : Application mobile';

  @override
  String get enterProjectName => 'Entrez le nom du projet.';

  @override
  String get description => 'Description';

  @override
  String get projectDescHint => 'Décrivez brièvement le projet…';

  @override
  String get startDate => 'Date de début';

  @override
  String get deadline => 'Date limite';

  @override
  String get status => 'Statut';

  @override
  String get deadlineAfterStart =>
      'La date limite doit être après la date de début.';

  @override
  String get createTheProject => 'Créer le projet';

  @override
  String get projectDetails => 'Détails du projet';

  @override
  String get deleteProjectTitle => 'Supprimer ce projet ?';

  @override
  String deleteProjectBody(String name) {
    return '« $name » et toutes ses tâches seront supprimés définitivement.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get tabDescription => 'Description';

  @override
  String get tabTasks => 'Tâches';

  @override
  String get tabMembers => 'Membres';

  @override
  String get noDescription => 'Aucune description.';

  @override
  String tasksDoneLabel(int count) {
    return '$count tâches terminées';
  }

  @override
  String lateCountLabel(int count) {
    return '$count en retard';
  }

  @override
  String get noMemberAssigned =>
      'Aucun membre assigné. Affectez des tâches depuis leur fiche.';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get noTaskForProject => 'Aucune tâche pour ce projet.';

  @override
  String lateOn(String date) {
    return 'En retard · $date';
  }
}
