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

  @override
  String get filterAllFem => 'Toutes';

  @override
  String get taskTodo => 'À faire';

  @override
  String get taskStatusDone => 'Terminée';

  @override
  String get priorityHigh => 'Haute';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityLow => 'Basse';

  @override
  String get kanbanBoard => 'Tableau Kanban';

  @override
  String get dropTaskHere => 'Déposez une tâche ici';

  @override
  String get noTaskHere => 'Aucune tâche ici';

  @override
  String get createProjectFirst => 'Créez d’abord un projet.';

  @override
  String get deletedProject => 'Projet supprimé';

  @override
  String projectDateLine(String project, String date) {
    return '$project · $date';
  }

  @override
  String get newTask => 'Nouvelle tâche';

  @override
  String get titleLabel => 'Titre';

  @override
  String get taskTitleHint => 'Ex : Conception de l’UI';

  @override
  String get enterTaskTitle => 'Entrez le titre de la tâche.';

  @override
  String get taskDescHint => 'Décrivez brièvement la tâche…';

  @override
  String get projectLabelShort => 'Projet';

  @override
  String get priorityLabel => 'Priorité';

  @override
  String get createTheTask => 'Créer la tâche';

  @override
  String get taskDetail => 'Détail de la tâche';

  @override
  String get deleteTaskTitle => 'Supprimer cette tâche ?';

  @override
  String deleteTaskBody(String title) {
    return '« $title » sera supprimée définitivement.';
  }

  @override
  String projectNameLine(String name) {
    return 'Projet : $name';
  }

  @override
  String get assignedTo => 'Assigné à';

  @override
  String get unassigned => 'Non assigné';

  @override
  String get assignTask => 'Affecter une tâche';

  @override
  String get taskLabel => 'Tâche';

  @override
  String get memberLabel => 'Membre';

  @override
  String get addMembersFirst => 'Ajoutez d’abord des membres (onglet Équipe).';

  @override
  String get assign => 'Affecter';

  @override
  String get noMembersYet => 'Aucun membre pour le moment';

  @override
  String get removeMemberTitle => 'Retirer ce membre ?';

  @override
  String removeMemberBody(String name) {
    return '« $name » sera retiré. Ses tâches redeviendront non assignées.';
  }

  @override
  String get remove => 'Retirer';

  @override
  String memberRoleTasks(String role, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tâches',
      one: '1 tâche',
    );
    return '$role · $_temp0';
  }

  @override
  String get projectLead => 'Cheffe de projet';

  @override
  String get newMember => 'Nouveau membre';

  @override
  String get memberNameHint => 'Ex : Amina Ben Ali';

  @override
  String get enterMemberName => 'Entrez le nom du membre.';

  @override
  String get roleLabel => 'Rôle';

  @override
  String get roleHint => 'Ex : Développeuse front';

  @override
  String get enterMemberRole => 'Entrez le rôle du membre.';

  @override
  String get addTheMember => 'Ajouter le membre';

  @override
  String get deadlinesTitle => 'Échéances';

  @override
  String get weekdayMon => 'L';

  @override
  String get weekdayTue => 'M';

  @override
  String get weekdayWed => 'M';

  @override
  String get weekdayThu => 'J';

  @override
  String get weekdayFri => 'V';

  @override
  String get weekdaySat => 'S';

  @override
  String get weekdaySun => 'D';

  @override
  String todayCount(int count) {
    return 'Aujourd’hui · $count';
  }

  @override
  String dateCount(String date, int count) {
    return '$date · $count';
  }

  @override
  String get noDeadlineThatDay => 'Aucune échéance ce jour-là.';

  @override
  String get moreTitle => 'Plus';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle => 'Retards, rappels et affectations';

  @override
  String get statsTile => 'Statistiques et progression';

  @override
  String get statsTileSubtitle => 'Évolution de vos tâches';

  @override
  String get reportsTile => 'Rapports';

  @override
  String get reportsTileSubtitle => 'Résumé global ou par projet';

  @override
  String get profileTile => 'Profil et paramètres';

  @override
  String get profileTileSubtitle => 'Compte, notifications, apparence';

  @override
  String filterUnread(int count) {
    return 'Non lues · $count';
  }

  @override
  String get markAllRead => 'Tout lire';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get notifOverdueTitle => 'Tâche en retard';

  @override
  String notifOverdueMsg(String task, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours',
      one: '1 jour',
    );
    return '« $task » a $_temp0 de retard';
  }

  @override
  String get notifReminderTitle => 'Rappel d’échéance';

  @override
  String notifReminderToday(String task) {
    return '« $task » arrive à échéance aujourd’hui';
  }

  @override
  String notifReminderTomorrow(String task) {
    return '« $task » arrive à échéance demain';
  }

  @override
  String notifReminderTwoDays(String task) {
    return '« $task » arrive à échéance dans 2 jours';
  }

  @override
  String get notifAssignTitle => 'Nouvelle affectation';

  @override
  String notifAssignMsg(String task, String member) {
    return '« $task » est assignée à $member';
  }

  @override
  String get progressTitle => 'Progression';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get thisMonth => 'Ce mois';

  @override
  String get statInProgress => 'En cours';

  @override
  String get overdueLabel => 'En retard';

  @override
  String percentOfTasks(int percent) {
    return '$percent % des tâches';
  }

  @override
  String get taskEvolution => 'Évolution des tâches';

  @override
  String daysAgo(int days) {
    return 'Il y a $days jours';
  }

  @override
  String get legendDone => 'Terminées';

  @override
  String get legendActive => 'En cours';

  @override
  String get legendLate => 'En retard';

  @override
  String get reportsTitle => 'Rapports';

  @override
  String get tabGlobal => 'Global';

  @override
  String get tabByProject => 'Par projet';

  @override
  String get noProjectYet => 'Aucun projet pour le moment';

  @override
  String get summary => 'Résumé';

  @override
  String get totalTasks => 'Total des tâches';

  @override
  String get avgResolution => 'Temps moyen de résolution';

  @override
  String get successRate => 'Taux de réussite';

  @override
  String get exportPdf => 'Exporter en PDF';

  @override
  String get pdfSoon => 'Export PDF : bientôt disponible.';

  @override
  String durationDaysHours(int days, int hours) {
    return '$days j $hours h';
  }

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get defaultUserName => 'Utilisateur';

  @override
  String get noEmail => 'Aucun e-mail';

  @override
  String get personalInfo => 'Informations personnelles';

  @override
  String get passwordItem => 'Mot de passe';

  @override
  String get notifPrefsItem => 'Préférences de notifications';

  @override
  String get languageItem => 'Langue';

  @override
  String get appearanceItem => 'Apparence';

  @override
  String get helpItem => 'Aide et support';

  @override
  String get logout => 'Déconnexion';

  @override
  String get logoutTitle => 'Se déconnecter ?';

  @override
  String get logoutBody => 'Vous reviendrez à l’écran d’accueil.';

  @override
  String get logoutConfirm => 'Se déconnecter';

  @override
  String get save => 'Enregistrer';

  @override
  String get profileUpdated => 'Profil mis à jour.';

  @override
  String get accountNotFound => 'Compte introuvable.';

  @override
  String get emailAlreadyUsed => 'Cet e-mail est déjà utilisé.';

  @override
  String get accountExists => 'Un compte existe déjà avec cet e-mail.';

  @override
  String get oldPasswordWrong => 'L’ancien mot de passe est incorrect.';

  @override
  String get oldPasswordLabel => 'Ancien mot de passe';

  @override
  String get oldPasswordHint => 'Votre mot de passe actuel';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get confirmPasswordLabel => 'Confirmer le nouveau mot de passe';

  @override
  String get confirmPasswordHint => 'Répétez le mot de passe';

  @override
  String get enterOldPassword => 'Entrez votre ancien mot de passe.';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get changePasswordButton => 'Modifier';

  @override
  String get passwordChanged => 'Mot de passe modifié.';

  @override
  String get notifSummaryAll => 'Toutes les alertes';

  @override
  String get notifSummaryNone => 'Aucune alerte';

  @override
  String get notifSummaryOverdue => 'Alertes de retard';

  @override
  String notifSummaryCount(int count) {
    return '$count sur 3 actives';
  }

  @override
  String get prefOverdueTitle => 'Alertes de retard';

  @override
  String get prefOverdueSub => 'Tâches qui ont dépassé leur date limite';

  @override
  String get prefReminderTitle => 'Rappels d’échéance';

  @override
  String get prefReminderSub => 'Tâches à rendre dans les 2 jours';

  @override
  String get prefAssignTitle => 'Nouvelles affectations';

  @override
  String get prefAssignSub => 'Tâches assignées à un membre';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get helpTitle => 'Aide et support';

  @override
  String get faqQ1 => 'Comment créer un projet ?';

  @override
  String get faqA1 =>
      'Ouvrez l’onglet Projets puis touchez le bouton + en bas à droite.';

  @override
  String get faqQ2 => 'Comment affecter une tâche ?';

  @override
  String get faqA2 =>
      'Ouvrez la tâche, touchez « Assigné à » et choisissez un membre de l’équipe.';

  @override
  String get faqQ3 => 'Comment déplacer une tâche dans le Kanban ?';

  @override
  String get faqA3 =>
      'Maintenez votre doigt sur la carte, puis glissez-la vers une autre colonne.';

  @override
  String get faqQ4 => 'Que signifie « en retard » ?';

  @override
  String get faqA4 =>
      'Une tâche est en retard quand sa date limite est passée et qu’elle n’est pas terminée.';

  @override
  String get helpContact =>
      'Besoin d’aide ? Écrivez-nous à support@teampulse.example';
}
