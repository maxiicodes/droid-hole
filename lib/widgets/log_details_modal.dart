import 'package:droid_hole/functions/format.dart';
import 'package:droid_hole/widgets/log_status.dart';
import 'package:flutter/material.dart';

import 'package:droid_hole/models/log.dart';

class LogDetailsModal extends StatelessWidget {
  final Log log;
  final double statusBarHeight;

  const LogDetailsModal({
    Key? key,
    required this.log,
    required this.statusBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    Widget _item(IconData icon, String label, Widget value) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: mediaQuery.size.width - 114,
                  child: value,
                )
              ],
            )
          ],
        ),
      );  
    }
    
    return Container(
      height: mediaQuery.orientation == Orientation.landscape
        ? mediaQuery.size.height - (statusBarHeight+10)
        : null,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Log details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _item(Icons.link, "URL", Text(log.url)),
              const SizedBox(height: 20),
              _item(Icons.http_rounded, "Type", Text(log.type)),
              const SizedBox(height: 20),
              _item(Icons.phone_android_rounded, "Device", Text(log.device)),
              const SizedBox(height: 20),
              _item(Icons.access_time_outlined, "Time", Text(formatTimestamp(log.dateTime, 'HH:mm:ss'))),
              const SizedBox(height: 20),
              _item(Icons.shield_outlined, "Status", LogStatus(status: log.status, showIcon: false)),
              const SizedBox(height: 20),
              if (log.status == '2' && log.answeredBy != null) ...[
                _item(Icons.domain, "Answered by", Text(log.answeredBy!)),
                const SizedBox(height: 20),
              ],
              _item(Icons.system_update_alt_outlined, "Reply", Text("${log.replyType} (${(log.replyTime/10)} ms)")),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context), 
                    icon: const Icon(Icons.close),
                    label: const Text("Close"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}