import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Create a list of slide animations for each day of the week (slide from bottom)
    _slideAnimations = List.generate(7, (index) {
      return Tween<Offset>(
        begin: const Offset(0.0, 1.0), // Start from the bottom
        end: Offset.zero, // End at the original position
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
    });

    // Start the animation once the screen is loaded
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and calculate the start and end of the week (Sunday to Saturday)
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    // Format dates to display
    final dateFormat = DateFormat('MMM dd');
    final startDate = dateFormat.format(startOfWeek);
    final endDate = dateFormat.format(endOfWeek);

    // Example data: Project name and task details for each day (this can be dynamic based on user data)
    final List<Map<String, String>> dailySchedule = [
      {'day': 'Sunday', 'project': 'Project Alpha'},
      {'day': 'Monday', 'project': 'Project Beta'},
      {'day': 'Tuesday', 'project': 'Project Gamma'},
      {'day': 'Wednesday', 'project': 'Project Delta'},
      {'day': 'Thursday', 'project': 'Project Epsilon'},
      {'day': 'Friday', 'project': 'Project Zeta'},
      {'day': 'Saturday', 'project': 'Project Eta'},
    ];

    // Get the current day of the week
    final currentDay = DateFormat('EEEE').format(now); // Get current day name

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Week date range
            Text(
              '$startDate - $endDate',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0), // Space between date and divider

            // Divider
            const Divider(
              color: Colors.grey,
              height: 2,
            ),
            const SizedBox(height: 16.0), // Space below the divider

            // Display schedule for each day of the week with animation
            Expanded(
              child: ListView.builder(
                itemCount: dailySchedule.length,
                itemBuilder: (context, index) {
                  final schedule = dailySchedule[index];

                  // Check if the current day matches the weekday
                  final isToday = schedule['day'] == currentDay;

                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(schedule['day']!),
                          if (isToday) ...[
                            // Green live dot next to the current day
                            SizedBox(width: 8.0),
                            CircleAvatar(
                              radius: 6.0,
                              backgroundColor: Colors.green,
                            ),
                          ]
                        ],
                      ),
                      subtitle: Text(schedule['project']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          _showJobDetails(context, schedule['project']!);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show a dialog with job details
  void _showJobDetails(BuildContext context, String projectName) {
    // Example data for job task details
    final jobDetails = {
      'task': 'Task: Concrete pouring',
      'address': '1234 Elm Street, City, State',
      'workers': 'John Doe, Jane Smith, Mark Johnson',
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$projectName - Job Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Task: ${jobDetails['task']}'),
              SizedBox(height: 8.0),
              Text('Address: ${jobDetails['address']}'),
              SizedBox(height: 8.0),
              Text('Workers: ${jobDetails['workers']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
