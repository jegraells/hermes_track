import 'package:flutter/material.dart';
import 'package:hermes_track/Screens/home_screen.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter 4-Digit ID',
                border: OutlineInputBorder(),
              ),
              maxLength: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Assuming login is successful
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(), // Navigate to HomeScreen
                  ),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
