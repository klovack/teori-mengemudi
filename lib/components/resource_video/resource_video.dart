import 'package:flutter/material.dart';
import 'package:roadcognizer/services/video_play_counter/video_play_counter.service.dart';
import 'package:video_player/video_player.dart';

class ResourceVideo extends StatefulWidget {
  final String assetUrl;
  final bool limitVideoPlay;
  final VideoPlayCounterService videoPlayCounterService =
      VideoPlayCounterService();

  ResourceVideo(this.assetUrl, {super.key, this.limitVideoPlay = true});

  @override
  State<ResourceVideo> createState() => _ResourceVideoState();
}

class _ResourceVideoState extends State<ResourceVideo> {
  late VideoPlayerController _controller;
  var _isPlaying = false;
  late int _playCount = 5;

  @override
  void initState() {
    super.initState();

    widget.videoPlayCounterService.getPlayCount(widget.assetUrl).then((value) {
      setState(() {
        _playCount = value;
      });
    });

    _controller =
        VideoPlayerController.asset('assets/videos/basics/salip_tidak_jadi.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
            _controller.addListener(() {
              if (_controller.value.isCompleted) {
                setState(() {
                  _isPlaying = false;
                });
              }
            });
          });
  }

  void persistPlayCount() async {
    await widget.videoPlayCounterService
        .setPlayCount(widget.assetUrl, _playCount);
  }

  @override
  Widget build(BuildContext context) {
    var videoTextHint = _playCount > 0
        ? 'Video bisa diputar $_playCount kali lagi'
        : 'Video sudah tidak bisa diputar lagi';

    return _controller.value.isInitialized
        ? Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (!_controller.value.isPlaying &&
                      (_playCount > 0 || !widget.limitVideoPlay)) {
                    setState(() {
                      _controller.play();
                      _isPlaying = true;
                      _playCount = _playCount - 1;
                    });
                    persistPlayCount();
                  }
                },
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    if (!_isPlaying)
                      Center(
                        heightFactor: 3,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (widget.limitVideoPlay) Text(videoTextHint)
            ],
          )
        : Container();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
