import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeOffRequestScreen extends StatefulWidget {
  @override
  _TimeOffRequestScreenState createState() => _TimeOffRequestScreenState();
}

class _TimeOffRequestScreenState extends State<TimeOffRequestScreen> {
  List<DateTime> _selectedDates = [];
  List<Map<String, dynamic>> _timeOffRequests = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void _onDaySelected(DateTime day, DateTime? focusedDay) {
    setState(() {
      if (_selectedDates.contains(day)) {
        _selectedDates.remove(day);
      } else {
        _selectedDates.add(day);
      }
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Time Off Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Selected Dates:'),
              SizedBox(height: 10),
              ..._selectedDates.map((date) => Text(
                "- ${date.toLocal().toString().split(' ')[0]}",
                style: TextStyle(fontSize: 14),
              )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _timeOffRequests.add({
                    'dates': List.from(_selectedDates),
                    'details': 'Time off request submitted',
                  });
                  _selectedDates.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Off Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => _selectedDates.contains(day),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedDates.isEmpty ? null : _showConfirmationDialog,
              child: Text('Submit Time Off Request'),
            ),
            SizedBox(height: 16),
            if (_timeOffRequests.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _timeOffRequests.length,
                  itemBuilder: (context, index) {
                    final request = _timeOffRequests[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text('Time Off Request'),
                        subtitle: Text(
                          "Dates: ${request['dates'].map((date) => date.toLocal().toString().split(' ')[0]).join(', ')}",
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Request Details'),
                                  content: Text(request['details']),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
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
}