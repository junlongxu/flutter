import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:getflutter/getflutter.dart';

// class TravelPage extends StatefulWidget {
//   _TravelPageState createState() => _TravelPageState();
// }

// class _TravelPageState extends State<TravelPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('TravelPage')
//     );
//   }
// }

class TravelPage extends StatefulWidget {
  final String url;
  const TravelPage({this.url});
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network('${widget.url}.mp4')
    // https://bitcdn-kronehit.bitmovin.com/v2/hls/chunklist_b3128000.m3u8
    _controller = VideoPlayerController.network('http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080619/1290895585221619714/mp4/036.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      }).catchError((e)=>{
        print('直播-->$e')
      });
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.black,
      height: double.infinity,
      child: _controller.value.initialized
          ? GestureDetector(
              onTap: () {
                print(_controller.value.aspectRatio);
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: 0.66, //_controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
          : loadingVideo(),
    );
  }

  Widget loadingVideo() => Container(
        color: Colors.black,
        child: Center(
          child: GFLoader(
            type: GFLoaderType.circle,
            loaderColorOne: Colors.blueAccent,
            loaderColorTwo: Colors.black,
            loaderColorThree: Colors.pink,
          ),
        ),
      );
}

