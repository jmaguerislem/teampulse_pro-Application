import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @welcomeTagline.
  ///
  /// In fr, this message translates to:
  /// **'Vos projets, en rythme.\nAlertes de retard avant qu’il ne soit trop tard.'**
  String get welcomeTagline;

  /// No description provided for @signIn.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get createAccount;

  /// No description provided for @continueWithoutAccount.
  ///
  /// In fr, this message translates to:
  /// **'Continuer sans compte'**
  String get continueWithoutAccount;

  /// No description provided for @navHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// No description provided for @navProjects.
  ///
  /// In fr, this message translates to:
  /// **'Projets'**
  String get navProjects;

  /// No description provided for @navTasks.
  ///
  /// In fr, this message translates to:
  /// **'Tâches'**
  String get navTasks;

  /// No description provided for @navTeam.
  ///
  /// In fr, this message translates to:
  /// **'Équipe'**
  String get navTeam;

  /// No description provided for @navMore.
  ///
  /// In fr, this message translates to:
  /// **'Plus'**
  String get navMore;

  /// No description provided for @loginTitle.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Heureux de vous revoir. Connectez-vous pour retrouver vos projets.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In fr, this message translates to:
  /// **'exemple@domaine.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get passwordLabel;

  /// No description provided for @yourPasswordHint.
  ///
  /// In fr, this message translates to:
  /// **'Votre mot de passe'**
  String get yourPasswordHint;

  /// No description provided for @enterEmail.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre e-mail.'**
  String get enterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In fr, this message translates to:
  /// **'Format d’e-mail invalide.'**
  String get invalidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre mot de passe.'**
  String get enterPassword;

  /// No description provided for @wrongCredentials.
  ///
  /// In fr, this message translates to:
  /// **'E-mail ou mot de passe incorrect.'**
  String get wrongCredentials;

  /// No description provided for @noAccountYet.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de compte ? '**
  String get noAccountYet;

  /// No description provided for @signupTitle.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Rejoignez TeamPulse Pro et gérez vos projets sans friction.'**
  String get signupSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nom complet'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex : Aya Jguirim'**
  String get fullNameHint;

  /// No description provided for @enterFullName.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre nom complet.'**
  String get enterFullName;

  /// No description provided for @passwordMinHint.
  ///
  /// In fr, this message translates to:
  /// **'Minimum 8 caractères'**
  String get passwordMinHint;

  /// No description provided for @passwordMinError.
  ///
  /// In fr, this message translates to:
  /// **'Minimum 8 caractères.'**
  String get passwordMinError;

  /// No description provided for @signUp.
  ///
  /// In fr, this message translates to:
  /// **'S’inscrire'**
  String get signUp;

  /// No description provided for @alreadyAccount.
  ///
  /// In fr, this message translates to:
  /// **'Déjà un compte ? '**
  String get alreadyAccount;

  /// No description provided for @hello.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour'**
  String get hello;

  /// No description provided for @helloName.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour {name}'**
  String helloName(String name);

  /// No description provided for @yourActivity.
  ///
  /// In fr, this message translates to:
  /// **'Votre activité'**
  String get yourActivity;

  /// No description provided for @globalProgress.
  ///
  /// In fr, this message translates to:
  /// **'Avancement global'**
  String get globalProgress;

  /// No description provided for @projectsInProgress.
  ///
  /// In fr, this message translates to:
  /// **'{count} projets en cours'**
  String projectsInProgress(int count);

  /// No description provided for @projectsDoneCount.
  ///
  /// In fr, this message translates to:
  /// **'{count} terminés'**
  String projectsDoneCount(int count);

  /// No description provided for @statProjects.
  ///
  /// In fr, this message translates to:
  /// **'Projets'**
  String get statProjects;

  /// No description provided for @statTasks.
  ///
  /// In fr, this message translates to:
  /// **'Tâches'**
  String get statTasks;

  /// No description provided for @statDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminées'**
  String get statDone;

  /// No description provided for @lateTasks.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 tâche en retard} other{{count} tâches en retard}}'**
  String lateTasks(int count);

  /// No description provided for @noLateTasks.
  ///
  /// In fr, this message translates to:
  /// **'Aucune tâche en retard'**
  String get noLateTasks;

  /// No description provided for @reactQuickly.
  ///
  /// In fr, this message translates to:
  /// **'Réagissez rapidement'**
  String get reactQuickly;

  /// No description provided for @allOnTime.
  ///
  /// In fr, this message translates to:
  /// **'Tout est dans les temps'**
  String get allOnTime;

  /// No description provided for @upcomingDeadlines.
  ///
  /// In fr, this message translates to:
  /// **'Échéances proches'**
  String get upcomingDeadlines;

  /// No description provided for @seeAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir tout'**
  String get seeAll;

  /// No description provided for @noDeadlines.
  ///
  /// In fr, this message translates to:
  /// **'Aucune échéance pour le moment'**
  String get noDeadlines;

  /// No description provided for @urgent.
  ///
  /// In fr, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @soon.
  ///
  /// In fr, this message translates to:
  /// **'Bientôt'**
  String get soon;

  /// No description provided for @late.
  ///
  /// In fr, this message translates to:
  /// **'En retard'**
  String get late;

  /// No description provided for @today.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd’hui'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In fr, this message translates to:
  /// **'Demain'**
  String get tomorrow;

  /// No description provided for @tasksCount.
  ///
  /// In fr, this message translates to:
  /// **'{count} tâches'**
  String tasksCount(int count);

  /// No description provided for @myProjects.
  ///
  /// In fr, this message translates to:
  /// **'Mes projets'**
  String get myProjects;

  /// No description provided for @filterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get filterAll;

  /// No description provided for @filterInProgress.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get filterInProgress;

  /// No description provided for @filterDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminés'**
  String get filterDone;

  /// No description provided for @filterOnHold.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get filterOnHold;

  /// No description provided for @noProjectHere.
  ///
  /// In fr, this message translates to:
  /// **'Aucun projet ici'**
  String get noProjectHere;

  /// No description provided for @statusDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get statusDone;

  /// No description provided for @tasksProgress.
  ///
  /// In fr, this message translates to:
  /// **'{done} / {total} tâches'**
  String tasksProgress(int done, int total);

  /// No description provided for @createProject.
  ///
  /// In fr, this message translates to:
  /// **'Créer un projet'**
  String get createProject;

  /// No description provided for @projectName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du projet'**
  String get projectName;

  /// No description provided for @projectNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex : Application mobile'**
  String get projectNameHint;

  /// No description provided for @enterProjectName.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le nom du projet.'**
  String get enterProjectName;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @projectDescHint.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez brièvement le projet…'**
  String get projectDescHint;

  /// No description provided for @startDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get startDate;

  /// No description provided for @deadline.
  ///
  /// In fr, this message translates to:
  /// **'Date limite'**
  String get deadline;

  /// No description provided for @status.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get status;

  /// No description provided for @deadlineAfterStart.
  ///
  /// In fr, this message translates to:
  /// **'La date limite doit être après la date de début.'**
  String get deadlineAfterStart;

  /// No description provided for @createTheProject.
  ///
  /// In fr, this message translates to:
  /// **'Créer le projet'**
  String get createTheProject;

  /// No description provided for @projectDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails du projet'**
  String get projectDetails;

  /// No description provided for @deleteProjectTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ce projet ?'**
  String get deleteProjectTitle;

  /// No description provided for @deleteProjectBody.
  ///
  /// In fr, this message translates to:
  /// **'« {name} » et toutes ses tâches seront supprimés définitivement.'**
  String deleteProjectBody(String name);

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @tabDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get tabDescription;

  /// No description provided for @tabTasks.
  ///
  /// In fr, this message translates to:
  /// **'Tâches'**
  String get tabTasks;

  /// No description provided for @tabMembers.
  ///
  /// In fr, this message translates to:
  /// **'Membres'**
  String get tabMembers;

  /// No description provided for @noDescription.
  ///
  /// In fr, this message translates to:
  /// **'Aucune description.'**
  String get noDescription;

  /// No description provided for @tasksDoneLabel.
  ///
  /// In fr, this message translates to:
  /// **'{count} tâches terminées'**
  String tasksDoneLabel(int count);

  /// No description provided for @lateCountLabel.
  ///
  /// In fr, this message translates to:
  /// **'{count} en retard'**
  String lateCountLabel(int count);

  /// No description provided for @noMemberAssigned.
  ///
  /// In fr, this message translates to:
  /// **'Aucun membre assigné. Affectez des tâches depuis leur fiche.'**
  String get noMemberAssigned;

  /// No description provided for @addTask.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une tâche'**
  String get addTask;

  /// No description provided for @noTaskForProject.
  ///
  /// In fr, this message translates to:
  /// **'Aucune tâche pour ce projet.'**
  String get noTaskForProject;

  /// No description provided for @lateOn.
  ///
  /// In fr, this message translates to:
  /// **'En retard · {date}'**
  String lateOn(String date);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
