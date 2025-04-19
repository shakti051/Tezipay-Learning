// navigation_event.dart
abstract class NavigationEvent {}

class NavigateToHome extends NavigationEvent {}

class NavigateToSettings extends NavigationEvent {}

class NavigateToAbout extends NavigationEvent {}
