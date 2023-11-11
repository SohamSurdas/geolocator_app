import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sms/sms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String locationText = "Press the button to get the location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location SMS App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locationText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
              },
              child: Text("Get Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendLocationViaSMS();
              },
              child: Text("Send Location via SMS"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        locationText =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        locationText = "Error getting location. Check permissions.";
      });
    }
  }

  void _sendLocationViaSMS() {
    // Replace with the recipient's phone number
    String phoneNumber = "1234567890";

    // Replace with your custom message
    String message = "My current location: $locationText";

    // Create an SMS message
    SmsMessage smsMessage = SmsMessage(
      phoneNumber,
      message,
    );

    // Send the SMS
    SmsSender sender = SmsSender();
    sender.sendSms(smsMessage);

    // Optional: Show a confirmation dialog or update UI
    // You may also want to handle errors and edge cases here
  }
}
