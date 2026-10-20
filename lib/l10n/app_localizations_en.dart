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
}
