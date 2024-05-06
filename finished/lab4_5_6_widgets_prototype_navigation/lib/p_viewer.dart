import 'package:flutter/material.dart';
import 'package:lab4_5/main.dart';
import 'package:lab4_5/second_page.dart';
import 'package:flutter/services.dart';

class PviewerPage extends StatelessWidget{
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  static const platformDial = const MethodChannel('samples.flutter.dev/phone_dialer');

  Future<void> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      print('Battery level at $result % .');
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  Future<void> _dialPhoneNumber() async {
    try {
      final String phoneNumber = "1234567890";
      await platformDial.invokeMethod('dialPhoneNumber', {"phoneNumber": phoneNumber});
    } on PlatformException catch (e) {
      print("Failed to dial phone number: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PageView Demo'),
        ),
        body: PageView(
          children: <Widget>[
            MyHomePage(),
            PagePricing(price1: '\$53/hr', price2: '\$45/hr', price3: '\$60/hr'),
            // Добавьте здесь другие страницы
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _dialPhoneNumber,
              tooltip: 'Dial Phone Number',
              child: Icon(Icons.phone),
            ),
            FloatingActionButton(
              onPressed: _getBatteryLevel,
              tooltip: 'Get Battery Level',
              child: Icon(Icons.battery_alert),
            ),
          ],
        ),
      ),
    );
  }
}
