import 'package:flutter/material.dart';
import 'package:practice_class/provider/notification_state_provider.dart';
import 'package:practice_class/utils/notification_state.dart';
import 'package:practice_class/widgets/title_form.dart';
import 'package:provider/provider.dart';

class NotificationField extends StatelessWidget {
  const NotificationField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleForm(
            'Notification:',
          ),
          const SizedBox.square(dimension: 4),
          ...NotificationState.values.map(
            (state) => Consumer<NotificationStateProvider>(
              builder: (_, provider, __) {
                return RadioListTile<NotificationState>(
                  value: state,
                  groupValue: provider.notificationState,
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(state.name),
                  onChanged: (value) {
                    provider.notificationState = value!;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}