// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTagline =>
      'Your projects, in rhythm.\nLate alerts before it\'s too late.';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Create an account';

  @override
  String get continueWithoutAccount => 'Continue without an account';

  @override
  String get navHome => 'Home';

  @override
  String get navProjects => 'Projects';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navTeam => 'Team';

  @override
  String get navMore => 'More';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Welcome back. Sign in to find your projects.';

  @override
  String get emailLabel => 'Email address';

  @override
  String get emailHint => 'example@domain.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get yourPasswordHint => 'Your password';

  @override
  String get enterEmail => 'Enter your email.';

  @override
  String get invalidEmail => 'Invalid email format.';

  @override
  String get enterPassword => 'Enter your password.';

  @override
  String get wrongCredentials => 'Incorrect email or password.';

  @override
  String get noAccountYet => 'No account yet? ';

  @override
  String get signupTitle => 'Create an account';

  @override
  String get signupSubtitle =>
      'Join TeamPulse Pro and manage your projects effortlessly.';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get fullNameHint => 'E.g. Aya Jguirim';

  @override
  String get enterFullName => 'Enter your full name.';

  @override
  String get passwordMinHint => 'At least 8 characters';

  @override
  String get passwordMinError => 'At least 8 characters.';

  @override
  String get signUp => 'Sign up';

  @override
  String get alreadyAccount => 'Already have an account? ';

  @override
  String get hello => 'Hello';

  @override
  String helloName(String name) {
    return 'Hello $name';
  }

  @override
  String get yourActivity => 'Your activity';

  @override
  String get globalProgress => 'Overall progress';

  @override
  String projectsInProgress(int count) {
    return '$count projects in progress';
  }

  @override
  String projectsDoneCount(int count) {
    return '$count completed';
  }

  @override
  String get statProjects => 'Projects';

  @override
  String get statTasks => 'Tasks';

  @override
  String get statDone => 'Completed';

  @override
  String lateTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks overdue',
      one: '1 task overdue',
    );
    return '$_temp0';
  }

  @override
  String get noLateTasks => 'No overdue tasks';

  @override
  String get reactQuickly => 'Act quickly';

  @override
  String get allOnTime => 'Everything is on schedule';

  @override
  String get upcomingDeadlines => 'Upcoming deadlines';

  @override
  String get seeAll => 'See all';

  @override
  String get noDeadlines => 'No deadlines for now';

  @override
  String get urgent => 'Urgent';

  @override
  String get soon => 'Soon';

  @override
  String get late => 'Overdue';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String tasksCount(int count) {
    return '$count tasks';
  }

  @override
  String get myProjects => 'My projects';

  @override
  String get filterAll => 'All';

  @override
  String get filterInProgress => 'In progress';

  @override
  String get filterDone => 'Completed';

  @override
  String get filterOnHold => 'On hold';

  @override
  String get noProjectHere => 'No projects here';

  @override
  String get statusDone => 'Completed';

  @override
  String tasksProgress(int done, int total) {
    return '$done / $total tasks';
  }

  @override
  String get createProject => 'Create a project';

  @override
  String get projectName => 'Project name';

  @override
  String get projectNameHint => 'E.g. Mobile app';

  @override
  String get enterProjectName => 'Enter the project name.';

  @override
  String get description => 'Description';

  @override
  String get projectDescHint => 'Briefly describe the project…';

  @override
  String get startDate => 'Start date';

  @override
  String get deadline => 'Deadline';

  @override
  String get status => 'Status';

  @override
  String get deadlineAfterStart => 'The deadline must be after the start date.';

  @override
  String get createTheProject => 'Create project';

  @override
  String get projectDetails => 'Project details';

  @override
  String get deleteProjectTitle => 'Delete this project?';

  @override
  String deleteProjectBody(String name) {
    return '“$name” and all its tasks will be permanently deleted.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get tabDescription => 'Description';

  @override
  String get tabTasks => 'Tasks';

  @override
  String get tabMembers => 'Members';

  @override
  String get noDescription => 'No description.';

  @override
  String tasksDoneLabel(int count) {
    return '$count tasks completed';
  }

  @override
  String lateCountLabel(int count) {
    return '$count overdue';
  }

  @override
  String get noMemberAssigned =>
      'No member assigned. Assign tasks from their detail page.';

  @override
  String get addTask => 'Add a task';

  @override
  String get noTaskForProject => 'No tasks for this project.';

  @override
  String lateOn(String date) {
    return 'Overdue · $date';
  }

  @override
  String get filterAllFem => 'All';

  @override
  String get taskTodo => 'To do';

  @override
  String get taskStatusDone => 'Completed';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get kanbanBoard => 'Kanban board';

  @override
  String get dropTaskHere => 'Drop a task here';

  @override
  String get noTaskHere => 'No tasks here';

  @override
  String get createProjectFirst => 'Create a project first.';

  @override
  String get deletedProject => 'Deleted project';

  @override
  String projectDateLine(String project, String date) {
    return '$project · $date';
  }

  @override
  String get newTask => 'New task';

  @override
  String get titleLabel => 'Title';

  @override
  String get taskTitleHint => 'E.g. UI design';

  @override
  String get enterTaskTitle => 'Enter the task title.';

  @override
  String get taskDescHint => 'Briefly describe the task…';

  @override
  String get projectLabelShort => 'Project';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get createTheTask => 'Create task';

  @override
  String get taskDetail => 'Task details';

  @override
  String get deleteTaskTitle => 'Delete this task?';

  @override
  String deleteTaskBody(String title) {
    return '“$title” will be permanently deleted.';
  }

  @override
  String projectNameLine(String name) {
    return 'Project: $name';
  }

  @override
  String get assignedTo => 'Assigned to';

  @override
  String get unassigned => 'Unassigned';

  @override
  String get assignTask => 'Assign a task';

  @override
  String get taskLabel => 'Task';

  @override
  String get memberLabel => 'Member';

  @override
  String get addMembersFirst => 'Add members first (Team tab).';

  @override
  String get assign => 'Assign';

  @override
  String get noMembersYet => 'No members yet';

  @override
  String get removeMemberTitle => 'Remove this member?';

  @override
  String removeMemberBody(String name) {
    return '“$name” will be removed. Their tasks will become unassigned.';
  }

  @override
  String get remove => 'Remove';

  @override
  String memberRoleTasks(String role, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return '$role · $_temp0';
  }

  @override
  String get projectLead => 'Project lead';

  @override
  String get newMember => 'New member';

  @override
  String get memberNameHint => 'E.g. Amina Ben Ali';

  @override
  String get enterMemberName => 'Enter the member name.';

  @override
  String get roleLabel => 'Role';

  @override
  String get roleHint => 'E.g. Front-end developer';

  @override
  String get enterMemberRole => 'Enter the member role.';

  @override
  String get addTheMember => 'Add member';

  @override
  String get deadlinesTitle => 'Deadlines';

  @override
  String get weekdayMon => 'M';

  @override
  String get weekdayTue => 'T';

  @override
  String get weekdayWed => 'W';

  @override
  String get weekdayThu => 'T';

  @override
  String get weekdayFri => 'F';

  @override
  String get weekdaySat => 'S';

  @override
  String get weekdaySun => 'S';

  @override
  String todayCount(int count) {
    return 'Today · $count';
  }

  @override
  String dateCount(String date, int count) {
    return '$date · $count';
  }

  @override
  String get noDeadlineThatDay => 'No deadlines that day.';

  @override
  String get moreTitle => 'More';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle => 'Overdue, reminders and assignments';

  @override
  String get statsTile => 'Statistics and progress';

  @override
  String get statsTileSubtitle => 'Evolution of your tasks';

  @override
  String get reportsTile => 'Reports';

  @override
  String get reportsTileSubtitle => 'Overall or per-project summary';

  @override
  String get profileTile => 'Profile and settings';

  @override
  String get profileTileSubtitle => 'Account, notifications, appearance';

  @override
  String filterUnread(int count) {
    return 'Unread · $count';
  }

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get notifOverdueTitle => 'Overdue task';

  @override
  String notifOverdueMsg(String task, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return '“$task” is $_temp0 overdue';
  }

  @override
  String get notifReminderTitle => 'Deadline reminder';

  @override
  String notifReminderToday(String task) {
    return '“$task” is due today';
  }

  @override
  String notifReminderTomorrow(String task) {
    return '“$task” is due tomorrow';
  }

  @override
  String notifReminderTwoDays(String task) {
    return '“$task” is due in 2 days';
  }

  @override
  String get notifAssignTitle => 'New assignment';

  @override
  String notifAssignMsg(String task, String member) {
    return '“$task” is assigned to $member';
  }

  @override
  String get progressTitle => 'Progress';

  @override
  String get thisWeek => 'This week';

  @override
  String get thisMonth => 'This month';

  @override
  String get statInProgress => 'In progress';

  @override
  String get overdueLabel => 'Overdue';

  @override
  String percentOfTasks(int percent) {
    return '$percent% of tasks';
  }

  @override
  String get taskEvolution => 'Task evolution';

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get legendDone => 'Completed';

  @override
  String get legendActive => 'In progress';

  @override
  String get legendLate => 'Overdue';

  @override
  String get reportsTitle => 'Reports';

  @override
  String get tabGlobal => 'Overall';

  @override
  String get tabByProject => 'By project';

  @override
  String get noProjectYet => 'No projects yet';

  @override
  String get summary => 'Summary';

  @override
  String get totalTasks => 'Total tasks';

  @override
  String get avgResolution => 'Average resolution time';

  @override
  String get successRate => 'Success rate';

  @override
  String get exportPdf => 'Export as PDF';

  @override
  String get pdfSoon => 'PDF export: coming soon.';

  @override
  String durationDaysHours(int days, int hours) {
    return '$days d $hours h';
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
  String get profileTitle => 'Profile';

  @override
  String get defaultUserName => 'User';

  @override
  String get noEmail => 'No email';

  @override
  String get personalInfo => 'Personal information';

  @override
  String get passwordItem => 'Password';

  @override
  String get notifPrefsItem => 'Notification preferences';

  @override
  String get languageItem => 'Language';

  @override
  String get appearanceItem => 'Appearance';

  @override
  String get helpItem => 'Help and support';

  @override
  String get logout => 'Log out';

  @override
  String get logoutTitle => 'Log out?';

  @override
  String get logoutBody => 'You will return to the welcome screen.';

  @override
  String get logoutConfirm => 'Log out';

  @override
  String get save => 'Save';

  @override
  String get profileUpdated => 'Profile updated.';

  @override
  String get accountNotFound => 'Account not found.';

  @override
  String get emailAlreadyUsed => 'This email is already in use.';

  @override
  String get accountExists => 'An account already exists with this email.';

  @override
  String get oldPasswordWrong => 'The old password is incorrect.';

  @override
  String get oldPasswordLabel => 'Old password';

  @override
  String get oldPasswordHint => 'Your current password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get confirmPasswordLabel => 'Confirm new password';

  @override
  String get confirmPasswordHint => 'Repeat the password';

  @override
  String get enterOldPassword => 'Enter your old password.';

  @override
  String get passwordsDontMatch => 'Passwords do not match.';

  @override
  String get changePasswordButton => 'Change';

  @override
  String get passwordChanged => 'Password changed.';

  @override
  String get notifSummaryAll => 'All alerts';

  @override
  String get notifSummaryNone => 'No alerts';

  @override
  String get notifSummaryOverdue => 'Overdue alerts';

  @override
  String notifSummaryCount(int count) {
    return '$count of 3 active';
  }

  @override
  String get prefOverdueTitle => 'Overdue alerts';

  @override
  String get prefOverdueSub => 'Tasks past their deadline';

  @override
  String get prefReminderTitle => 'Deadline reminders';

  @override
  String get prefReminderSub => 'Tasks due within 2 days';

  @override
  String get prefAssignTitle => 'New assignments';

  @override
  String get prefAssignSub => 'Tasks assigned to a member';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get helpTitle => 'Help and support';

  @override
  String get faqQ1 => 'How do I create a project?';

  @override
  String get faqA1 =>
      'Open the Projects tab, then tap the + button at the bottom right.';

  @override
  String get faqQ2 => 'How do I assign a task?';

  @override
  String get faqA2 =>
      'Open the task, tap “Assigned to” and choose a team member.';

  @override
  String get faqQ3 => 'How do I move a task in the Kanban board?';

  @override
  String get faqA3 =>
      'Press and hold the card, then drag it to another column.';

  @override
  String get faqQ4 => 'What does “overdue” mean?';

  @override
  String get faqA4 =>
      'A task is overdue when its deadline has passed and it is not completed.';

  @override
  String get helpContact =>
      'Need help? Write to us at support@teampulse.example';
}
