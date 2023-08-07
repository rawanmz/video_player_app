import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

import '../common/colors.dart' as color;

class CardioVideoInfo extends StatefulWidget {
  const CardioVideoInfo({Key? key}) : super(key: key);

  @override
  _CardioVideoInfoState createState() => _CardioVideoInfoState();
}

class _CardioVideoInfoState extends State<CardioVideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  String? time;

  VideoPlayerController? _controller;

  void _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/cardioworkout.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: _playArea == false
              ? BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    color.AppColor.gradientFirst.withOpacity(0.9),
                    color.AppColor.gradientSecond
                  ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight))
              : BoxDecoration(
            color: color.AppColor.gradientSecond,
          ),
          child: Column(
            children: [
              _playArea == false
                  ? Container(
                padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageIconColor),
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageIconColor)
                      ],
                    ),
                    SizedBox(height: 30),
                    Text("Legs Toning \nand Glutes Workout",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor)),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.timer,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor),
                              SizedBox(width: 5),
                              Text("60 min",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: color
                                          .AppColor.secondPageIconColor)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 250,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.handyman,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor),
                              SizedBox(width: 5),
                              Text("Resistance band,kettebel",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: color
                                          .AppColor.secondPageIconColor)),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
                  : Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      padding:
                      const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_ios,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor)),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageTopIconColor)
                        ],
                      ),
                    ),
                    _playView(context),
                    _controllView(context)
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Row(
                          children: [
                            SizedBox(width: 30),
                            Text("Circuits 1:Legs Toning",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: color.AppColor.circuitsColor)),
                            Expanded(child: Container()),
                            Row(
                              children: [
                                Icon(
                                  Icons.loop,
                                  size: 30,
                                  color: color.AppColor.loopColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("3 Sets",
                                    style: TextStyle(
                                        fontSize: 15, color: color.AppColor.setsColor)),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(child: _listView())
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  String convertTow(int value) {
    return value < 10 ? "0$value" : "$value";
  }


  Widget _controllView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remind = max(0, duration - head);
    final mins =convertTow(remind ~/ 60.0);
    final secs = convertTow(remind % 60);


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        VideoProgressIndicator(
          _controller!,//controller
          allowScrubbing: true,
          colors: VideoProgressColors(
            playedColor: Colors.red,
            bufferedColor: Colors.black12,
            backgroundColor: Colors.black,
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 5),
            color: color.AppColor.gradientSecond,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      decoration:
                      BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 4.0,
                            color: Color.fromARGB(50, 0, 0, 0))
                      ]),
                      child: Icon(
                        noMute ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (noMute) {
                      _controller?.setVolume(0);
                    } else {
                      _controller?.setVolume(1.0);
                    }
                    setState(() {});
                  },
                ),
                FlatButton(
                    onPressed: () async {
                      final index = _isPlayingIndex - 1;
                      if (index >= 0 && videoInfo.length >= 0) {
                        _initializeVideo(index);
                      } else {
                        Get.snackbar("Video", "",
                            snackPosition: SnackPosition.BOTTOM,
                            icon: Icon(
                              Icons.error,
                              size: 30,
                              color: Colors.white,
                            ),
                            backgroundColor: color.AppColor.gradientSecond,
                            colorText: Colors.white,
                            messageText: Text(
                              "No More Video Ahead",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white),
                            ));
                      }
                    },
                    child: Icon(
                      Icons.fast_rewind,
                      size: 26,
                      color: Colors.white,
                    )),
                FlatButton(
                    onPressed: () async {
                      if (_isPlaying) {
                        setState(() {
                          _isPlaying = false;
                        });
                        _controller?.pause();
                      } else {
                        setState(() {
                          _isPlaying = true;
                        });
                        _controller?.play();
                      }
                    },
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 26,
                      color: Colors.white,
                    )),
                FlatButton(
                    onPressed: () async {
                      final index = _isPlayingIndex + 1;
                      if (index <= videoInfo.length - 1) {
                        _initializeVideo(index);
                      } else {
                        Get.snackbar("Video", "",
                            snackPosition: SnackPosition.BOTTOM,
                            icon: Icon(
                              Icons.error,
                              size: 30,
                              color: Colors.white,
                            ),
                            backgroundColor: color.AppColor.gradientSecond,
                            colorText: Colors.white,
                            messageText: Text(
                              "You finished All workout YAY",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white),
                            ));
                      }
                    },
                    child: Icon(
                      Icons.fast_forward,
                      size: 26,
                      color: Colors.white,
                    )),
                Text(
                  _controller!.value.position.inMinutes.toString() +
                      ":" + _controller!.value.position.inSeconds.toString() +
                      "/" +
                      convertTime(_controller!.value.duration.inMilliseconds),
                  //time!,
                  style: TextStyle(color: Colors.white, shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    )
                  ]),
                )
              ],
            ))
      ],
    );
  }
  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  _listView() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        itemCount: videoInfo.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              _onTapVideo(index);
              debugPrint(index.toString());
              setState(() {
                //trigger signal to redraw a widget
                if (_playArea == false) {
                  _playArea = true;
                }
              });
            },
            child: _buildCard(index),
          );
        });
  }

  _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
                "Loading please waite",
                style: TextStyle(fontSize: 20, color: Colors.white60),
              )));
    }
  }


  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller is not Initialized ");
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) {
      return;
    }
    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    if (playing) {
      //handel progress
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble()/duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller =
    VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }

    setState(() {});
    controller..initialize().then((_) {
      old?.dispose();
      _isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      _controller?.play();
      setState(() {

      });
    });
  }

  _onTapVideo(int index) {
    _initializeVideo(index);
  }

  _buildCard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(videoInfo[index]["thumbnail"]),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]["title"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      videoInfo[index]["time"],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "15 rest",
                    style: TextStyle(color: Color(0xFF839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                          color: Color(0xFF839fed),
                          borderRadius: BorderRadius.circular(2)),
                    )
                        : Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2)),
                    )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  String convertTime(int time) {
    int centiseconds = (time % 1000) ~/ 10;
    time ~/= 1000;
    int seconds = time % 60;
    time ~/= 60;
    int minutes = time % 60;
    time ~/= 60;
    int hours = time;
    if (hours > 0) {
      return "$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}.${_twoDigits(centiseconds)}";
    } else if (minutes > 0) {
      return "$minutes:${_twoDigits(seconds)}.${_twoDigits(centiseconds)}";
    } else {
      return "$seconds:${_twoDigits(centiseconds)}";
    }
  }

  String _twoDigits(int time) {
    return "${time<10?'0':''}$time";
  }
}
