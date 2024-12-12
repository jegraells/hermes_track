import 'package:flutter/material.dart';
import 'weekly_hours_screen.dart';
import 'schedule_screen.dart';
import 'time_off_request_screen.dart';
import 'job_site_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClockedIn = false;
  String? currentJobSite;

  void _handleJobSiteSelection(String jobSite) {
    setState(() {
      isClockedIn = true;
      currentJobSite = jobSite;
    });
  }

  void _handleClockOut() {
    setState(() {
      isClockedIn = false;
      currentJobSite = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hermes Track"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/placeholder.png'), // Placeholder image for now
            ),
            const SizedBox(height: 10),
            const Text(
              "User Name", // Replace with dynamic user name later
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Four Squares Section
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              children: [
                // Clock In/Out button
                Card(
                  color: isClockedIn ? Colors.red : Colors.green,
                  child: InkWell(
                    onTap: () {
                      if (isClockedIn) {
                        _handleClockOut();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobSiteSelectionScreen(
                              onJobSiteSelected: _handleJobSiteSelection,
                            ),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        isClockedIn
                            ? "Clock Out\n$currentJobSite"
                            : "Clock In",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                // My Weekly Hours Button
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WeeklyHoursScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.blue,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "My Weekly Hours",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Schedule Button
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.orange,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Schedule",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Time Off Request Button
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeOffRequestScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.beach_access_rounded,
                            color: Colors.purple,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Time Off Request",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
