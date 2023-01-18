import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> CreateOrderNotification() async {
  int createUniqueId() {
    return DateTime.now().microsecondsSinceEpoch.remainder(10000);
  }

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.money_money_bag} Order Conformed!!!',
      body: 'This Product Dilivery Soon To you',
      bigPicture: "asset://assets/22.png",
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
