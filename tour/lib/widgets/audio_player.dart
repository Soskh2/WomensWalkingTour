import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key, required this.url});
  final String url;

  @override
  AudioPlayerWidgetState createState() => AudioPlayerWidgetState();
}

class AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isBuffering = false;
  double currentPosition = 0.0;
  double duration = 0.0;
  double speed = 1.0;
  late StreamSubscription _positionSubscription;
  late StreamSubscription _durationSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Listen for position changes
    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position.inSeconds.toDouble();
      });
    });

    // Listen for duration change
    _durationSubscription = _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void playAudio() async {
    await _audioPlayer.play(UrlSource(widget.url));
    setState(() {
      isPlaying = true;
    });
  }

  void pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      currentPosition = 0.0;
    });
  }

  void seekAudio(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  void changePlaybackSpeed(double value) {
    setState(() {
      speed = value;
    });
    _audioPlayer.setPlaybackRate(speed);
  }

  @override
  Widget build(BuildContext context) {
    // Format time display
    String formatTime(double timeInSeconds) {
      int minutes = (timeInSeconds / 60).floor();
      int seconds = (timeInSeconds % 60).toInt();
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }

    return Column(
      children: [
        // Audio Control Bar
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Center(
                  child: Text(
                'Listen Below:',
                style: TextStyle(
                  fontSize: 16, // Set the font size to 16
                ),
              )),
              Row(
                children: [
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: isPlaying ? pauseAudio : playAudio,
                    iconSize: 32,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  Text(
                    formatTime(currentPosition),
                    style: TextStyle(fontSize: 14),
                  ),
                  Expanded(
                    child: Slider(
                      value: currentPosition,
                      min: 0.0,
                      max: duration > 0.0 ? duration : 1.0,
                      onChanged: (value) {
                        seekAudio(value);
                      },
                      activeColor: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  Text(
                    '-${formatTime(duration - currentPosition)}',
                    style: TextStyle(fontSize: 14),
                  ),
                  PopupMenuButton<double>(
                    icon: Icon(Icons.more_horiz),
                    onSelected: (value) {
                      changePlaybackSpeed(value);
                    },
                    iconColor: Theme.of(context).secondaryHeaderColor,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<double>(
                          value: 0.5,
                          child: Text('0.5x'),
                        ),
                        PopupMenuItem<double>(
                          value: 1.0,
                          child: Text('1.0x'),
                        ),
                        PopupMenuItem<double>(
                          value: 1.5,
                          child: Text('1.5x'),
                        ),
                        PopupMenuItem<double>(
                          value: 1.75,
                          child: Text('1.75x'),
                        ),
                        PopupMenuItem<double>(
                          value: 2.0,
                          child: Text('2.0x'),
                        ),
                      ];
                    },
                  )
                ],
              ),
            ])),
      ],
    );
  }
}
