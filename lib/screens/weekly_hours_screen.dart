import 'package:flutter/material.dart';

class WeeklyHoursScreen extends StatefulWidget {
  const WeeklyHoursScreen({super.key});

  @override
  _WeeklyHoursScreenState createState() => _WeeklyHoursScreenState();
}

class _WeeklyHoursScreenState extends State<WeeklyHoursScreen>
    with TickerProviderStateMixin {  // Use TickerProviderStateMixin instead
  late AnimationController _controllerWeekdays;
  late AnimationController _controllerDividers;
  late Animation<Offset> _slideAnimationWeekdays;
  late Animation<Offset> _slideAnimationDividers;

  final List<Map<String, dynamic>> weeklyHours = [
    {'day': 'Monday', 'hours': 8},
    {'day': 'Tuesday', 'hours': 7},
    {'day': 'Wednesday', 'hours': 8},
    {'day': 'Thursday', 'hours': 6},
    {'day': 'Friday', 'hours': 3.5},
    {'day': 'Saturday', 'hours': 0},
    {'day': 'Sunday', 'hours': 0},
  ];

  @override
  void initState() {
    super.initState();
    _controllerWeekdays = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controllerDividers = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimationWeekdays = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen (right)
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controllerWeekdays,
      curve: Curves.easeInOut,
    ));

    _slideAnimationDividers = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen (right)
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controllerDividers,
      curve: Curves.easeInOut,
    ));

    // Start the weekdays animation
    _controllerWeekdays.forward();

    // Start the dividers animation with a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _controllerDividers.forward();
    });
  }

  @override
  void dispose() {
    _controllerWeekdays.dispose();
    _controllerDividers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalHours = weeklyHours.fold(
        0, (sum, dayData) => sum + dayData['hours']);

    // Formatting the total hours for better readability
    String formattedTotalHours = totalHours > 0
        ? totalHours.toStringAsFixed(2)
        : '0.00';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Hours'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Total Hours Display (with animation)
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 0.0,
                end: totalHours,
              ),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Text(
                  value.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 72, // 50% bigger than before
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Total Hours This Week',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Daily Hours List with sliding animation
            Expanded(
              child: ListView.builder(
                itemCount: weeklyHours.length,
                itemBuilder: (context, index) {
                  final dayData = weeklyHours[index];

                  // Set color based on the hours worked
                  Color hourColor = dayData['hours'] == 0
                      ? Colors.grey
                      : dayData['hours'] <= 4
                          ? Colors.amber // Mustard color
                          : dayData['hours'] >= 4.5
                              ? Colors.green // Normal Green color
                              : Colors.black;

                  return Column(
                    children: [
                      // Weekday with animation
                      SlideTransition(
                        position: _slideAnimationWeekdays,
                        child: ListTile(
                          title: Text(
                            dayData['day'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: Text(
                            dayData['hours'] == 0
                                ? 'No hours worked'
                                : '${dayData['hours']} hrs',
                            style: TextStyle(
                              fontSize: 18, // Increased font size for hours
                              fontWeight: FontWeight.bold, // Bold font
                              color: hourColor,
                            ),
                          ),
                        ),
                      ),
                      // Subtle Divider with animation delay
                      SlideTransition(
                        position: _slideAnimationDividers,
                        child: Divider(
                          color: Colors.grey.withOpacity(0.5),
                          height: 1,
                          thickness: 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
