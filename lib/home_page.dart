import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player_app/common/dimentions.dart';
import 'package:video_player_app/video/abs_video_info.dart';
import 'package:video_player_app/video/arms_video.dart';
import 'package:video_player_app/video/cardio_video_info.dart';
import 'package:video_player_app/video/legs_video_info.dart';

import 'bmi/bmi_page.dart';
import 'common/colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];

  void _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/info.json")
        .then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height + Dimensions.height150,
          padding:  EdgeInsets.only(top: Dimensions.height10*7, right: Dimensions.width15*2, left:  Dimensions.width15*2),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Training",
                      style: TextStyle(
                          fontSize: 30,
                          color: color.AppColor.homePageTitle,
                          fontWeight: FontWeight.w700)),
                  Expanded(child: Container()),
                  Icon(Icons.arrow_back_ios,
                      size: Dimensions.iconSize20, color: color.AppColor.homePageIcons),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Icon(Icons.calendar_today_outlined,
                      size: Dimensions.iconSize20, color: color.AppColor.homePageIcons),
                  SizedBox(
                    width: Dimensions.width15,
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: Dimensions.iconSize20, color: color.AppColor.homePageIcons),
                ],
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Row(
                children: [
                  Text("Your program",
                      style: TextStyle(
                          fontSize: 20,
                          color: color.AppColor.homePageSubtitle,
                          fontWeight: FontWeight.w700)),
                  Expanded(child: Container()),
                  Text("Detail",
                      style: TextStyle(
                          fontSize: 20, color: color.AppColor.homePageDetail)),
                  SizedBox(width: Dimensions.width10/2),
                  InkWell(
                    onTap: () {
                      //Get.to(()=>VideoInfo());
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: Dimensions.iconSize20,
                      color: color.AppColor.homePageIcons,
                    ),
                  )
                ],
              ),
              SizedBox(height: Dimensions.height20),
              InkWell(
                onTap: () {
                  Get.to(() => BMIPage());
                },
                child: Container(
                    width: MediaQuery.of(context).size.width, //get screen width
                    height: Dimensions.pageViewContainer,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              color.AppColor.gradientFirst.withOpacity(0.8),
                              color.AppColor.gradientSecond.withOpacity(0.9),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20/2),
                            bottomLeft: Radius.circular(Dimensions.radius20/2),
                            bottomRight: Radius.circular(Dimensions.radius20/2),
                            topRight: Radius.circular(Dimensions.radius20*4)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(5, 10),
                              blurRadius: 20,
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.2))
                        ]),

                    child: Container(
                      padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20, right: Dimensions.width20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text("BMI Calculator",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: color
                                            .AppColor.homePageContainerTextSmall,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Stack(
                                children:[
                                Padding(
                                  padding:EdgeInsets.only(right: Dimensions.width10*5,top: Dimensions.height10) ,
                                  child: Text("It's a good way to gauge whether your weight is in healthy proportion to your height.",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: color
                                              .AppColor.homePageContainerTextSmall)),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(left: Dimensions.width170),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(pi),
                                    child: Container(
                                        alignment: Alignment.bottomRight,
                                        width: Dimensions.height200,
                                        height: Dimensions.height150,
                                        child: Image.asset('assets/icon.png'),
                                      ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: Dimensions.height10/2),
              Container(
                height: Dimensions.height180,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:  EdgeInsets.only(top: Dimensions.height30),
                      height:Dimensions.bottomHeightBar,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          image: DecorationImage(
                              image: AssetImage("assets/card.jpg"),
                              fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-1, -5),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3),
                            ),
                          ]),
                    ),
                    Container(
                      height: Dimensions.height200,
                      width: MediaQuery.of(context).size.width,
                      margin:  EdgeInsets.only(right: Dimensions.height200, bottom: Dimensions.height30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                          image: AssetImage("assets/figure.png"),
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height200/2,
                      margin: EdgeInsets.only(left: Dimensions.height150, top: Dimensions.height200/4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("You are doing grate",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: color.AppColor.homePageDetail,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: Dimensions.height10),
                          RichText(
                              text: TextSpan(
                                  text: "keep it up\n",
                                  style: TextStyle(
                                      color: color.AppColor.homePagePlanColor,
                                      fontSize: 16),
                                  children: [
                                TextSpan(text: "stick to your plan")
                              ]))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Area of focus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: color.AppColor.homePageTitle),
                  )
                ],
              ),
              Expanded(
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                        itemCount: (info.length.toDouble() / 2).toInt(),
                        itemBuilder: (_, i) {
                          int a = 2 * i; //0,2
                          int b = 2 * i + 1; //1,3
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (a == 0) {
                                    Get.to(() => LegsVideoInfo());
                                  }
                                  if (a == 2) {
                                    Get.to(() => CardioVideoInfo());
                                  }
                                },
                                child: Container(
                                  height: Dimensions.height150,
                                  width:
                                      (MediaQuery.of(context).size.width - 90) /
                                          2,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width30, bottom: Dimensions.height10, top: Dimensions.height15),
                                  padding: EdgeInsets.only(bottom: Dimensions.height15/3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                                      image: DecorationImage(
                                          image: AssetImage(info[a]['img'])),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(5, 5),
                                            color: color.AppColor.gradientSecond
                                                .withOpacity(0.1)),
                                        BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(-5, -5),
                                            color: color.AppColor.gradientSecond
                                                .withOpacity(0.1))
                                      ]),
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        info[a]["title"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                color.AppColor.homePageDetail),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (b == 1) {
                                    Get.to(() => AbsVideoInfo());
                                  }
                                  if (b == 3) {
                                    Get.to(() => ArmsVideoInfo());
                                  }
                                },
                                child: Container(
                                  height: Dimensions.height150,
                                  width:
                                      (MediaQuery.of(context).size.width - 90) /
                                          2,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.height30, bottom: Dimensions.height10, top: Dimensions.height15),
                                  padding: EdgeInsets.only(bottom: Dimensions.height10/2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                                      image: DecorationImage(
                                          image: AssetImage(info[b]['img'])),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(5, 5),
                                            color: color.AppColor.gradientSecond
                                                .withOpacity(0.1)),
                                        BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(-5, -5),
                                            color: color.AppColor.gradientSecond
                                                .withOpacity(0.1))
                                      ]),
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        info[b]["title"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                color.AppColor.homePageDetail),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
