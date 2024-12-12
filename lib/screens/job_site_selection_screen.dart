import 'package:flutter/material.dart';

class JobSiteSelectionScreen extends StatelessWidget {
  final Function(String) onJobSiteSelected;

  JobSiteSelectionScreen({required this.onJobSiteSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Job Site'),
      ),
      body: ListView(
        children: [
          _buildJobSiteTile(context, 'Shop', Icons.build_rounded, 'shop'),
          _buildJobSiteTile(context, 'Office', Icons.coffee_rounded, 'office'),
          _buildJobSiteTile(context, 'Drive', Icons.fire_truck_rounded, 'drive'),
          _buildJobSiteTile(context, 'Excavator', Icons.engineering_rounded, 'excavator'),
        ],
      ),
    );
  }

  Widget _buildJobSiteTile(BuildContext context, String title, IconData icon, String jobSite) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(title),
      onTap: () {
        onJobSiteSelected(jobSite); // Return the selected job site

        // Show the "You're clocked in" custom message
        _showClockedInMessage(context);

        Navigator.pop(context); // Close the job site selection screen
      },
    );
  }

  // Function to show the custom "You're clocked in" message
  void _showClockedInMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 8),
          Text(
            "You're clocked in",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );

    // Show the snack bar in the center of the screen
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
