import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? startTime;
  Duration duration = const Duration(minutes: 25);
  bool isStarted = false;

  startTimebotton() {
    startTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (duration.inMinutes > 0) {
          int newSecond = duration.inSeconds - 1;
          duration = Duration(seconds: newSecond);
          isStarted = true;
        } else {
          duration = Duration(minutes: 25);
          timer.cancel();
          isStarted = false;
        }
      });
    });
  }

  void canselTimerCount() {
    startTime!.cancel();
    setState(() {
      duration = Duration(minutes: 25);
      isStarted = false;
    });
  }

  void stopResumeTimerCount() {
    setState(() {
      if (startTime!.isActive) {
        startTime!.cancel();
      } else {
        startTimebotton();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pomodoro App",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              
              addAutomaticKeepAlive: true,
              progressColor: Colors.green,
              backgroundColor: Colors.blue,
              percent: duration.inMinutes/25,
              lineWidth: 5.0,
              animation: true,
                animationDuration: 250,
                animateFromLastPercent: true,
              radius: 90,
              center: Text(
                "${duration.inMinutes.toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                style: const TextStyle(fontSize: 48),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            isStarted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          stopResumeTimerCount();
                        },
                        child: Text(
                          startTime!.isActive ? "Stop Timer" : "Resume",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          canselTimerCount();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimebotton();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
