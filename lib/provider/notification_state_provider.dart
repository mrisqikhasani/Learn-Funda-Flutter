import 'package:flutter/widgets.dart';
import 'package:practice_class/utils/notification_state.dart';

class NotificationStateProvider extends ChangeNotifier {
  //
  NotificationState _notificationState = NotificationState.enable;

  NotificationState get notificationState => _notificationState;

  set notificationState(NotificationState value) {
    _notificationState = value;
    notifyListeners();
  }
}