import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:flutter/material.dart';

createPersistentNotification() async {
  await AwesomeNotifications().resetGlobalBadge();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 0,
      channelKey: 'persistent_notification',
      title: '💰 TOTAL: ₹ ${TransactionDB.instance.totalamount.value}',
      body:
          '⬆️ INCOME: ₹ ${TransactionDB.instance.incomeTotal.value} ⬇️  EXPENSE: ₹ ${TransactionDB.instance.expenseTotal.value}',
      notificationLayout: NotificationLayout.Default,
      autoDismissible: false,
      locked: true,
      displayOnBackground: true,
      //icon: 'logo'
    ),
    actionButtons: [
      NotificationActionButton(
          key: 'EDIT',
          label: 'Close',
          color: Colors.teal,
          autoDismissible: true,
          buttonType: ActionButtonType.DisabledAction)
    ],
  );
}
